import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/categories.dart';
import '../../core/format.dart';
import '../../core/l10n.dart';
import '../../core/theme.dart';
import '../../data/calculations/wallets.dart';
import '../../data/models/transaction.dart';
import '../../state/transactions_provider.dart';
import '../../state/wallets_provider.dart';
import '../widgets/money_text.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();

  TxType _type = TxType.expense;
  late String _categoryId;
  String? _walletId;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _categoryId = expenseCategories.first.id; // sensible default = less work
    final wallets = ref.read(walletsProvider);
    if (wallets.isNotEmpty) _walletId = wallets.first.id;
    _amountCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  List<Category> get _categories =>
      _type == TxType.expense ? expenseCategories : incomeCategories;

  void _addQuick(int v) {
    final current = parseAmount(_amountCtrl.text) ?? 0;
    final next = (current + v).round().toString();
    _amountCtrl.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: next.length),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(), // prevention: no future dates
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _walletId == null) return;
    final l10n = context.l10n;
    final amount = parseAmount(_amountCtrl.text)!;
    final balance = ref.read(walletBalancesProvider)[_walletId] ?? 0;
    final shortfall = walletShortfall(balance, amount);

    if (_type == TxType.expense && shortfall > 0) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(l10n.notEnoughBalance),
          content: Text(
            l10n.overdrawDialog(c.money(shortfall), c.money(balance)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(l10n.edit),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(l10n.saveAnyway),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }
    if (!mounted) return;

    final title = _titleCtrl.text.trim().isEmpty
        ? categoryName(l10n, _categoryId)
        : _titleCtrl.text.trim();
    ref
        .read(transactionsProvider.notifier)
        .add(
          Transaction(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: title,
            amount: amount,
            type: _type,
            categoryId: _categoryId,
            walletId: _walletId!,
            date: _date,
          ),
        );
    final messenger = ScaffoldMessenger.of(context);
    final saved = l10n.savedTransaction(title, context.money(amount));
    Navigator.of(context).pop();
    messenger.showSnackBar(SnackBar(content: Text(saved)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final wallets = ref.watch(walletsProvider);
    final balances = ref.watch(walletBalancesProvider);
    final scheme = Theme.of(context).colorScheme;
    final isExpense = _type == TxType.expense;
    final amount = parseAmount(_amountCtrl.text);
    final balance = balances[_walletId] ?? 0;
    final shortfall = walletShortfall(balance, amount ?? 0);
    final overdraw = isExpense && amount != null && amount > 0 && shortfall > 0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addTransaction)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(kPad),
          children: [
            SegmentedButton<TxType>(
              segments: [
                ButtonSegment(
                  value: TxType.expense,
                  label: Text(l10n.expense),
                  icon: const Icon(Icons.arrow_upward),
                ),
                ButtonSegment(
                  value: TxType.income,
                  label: Text(l10n.income),
                  icon: const Icon(Icons.arrow_downward),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() {
                _type = s.first;
                _categoryId = _categories.first.id;
              }),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountCtrl,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                labelText: l10n.amount,
                suffixText: l10n.currency,
                border: const OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return l10n.enterAmount;
                final a = parseAmount(v);
                if (a == null) return l10n.numbersOnly;
                if (a <= 0) return l10n.amountPositive;
                if (a > 100000000) return l10n.amountTooLarge;
                return null;
              },
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final v in const [500, 1000, 2000, 5000])
                  ActionChip(label: Text('+$v'), onPressed: () => _addQuick(v)),
              ],
            ),
            if (overdraw) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: scheme.onTertiaryContainer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.overdrawHint(
                          context.money(shortfall),
                          context.money(balance),
                        ),
                        style: TextStyle(color: scheme.onTertiaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(l10n.category, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _categories)
                  ChoiceChip(
                    avatar: Icon(c.icon, size: 18, color: c.color),
                    label: Text(categoryName(l10n, c.id)),
                    selected: _categoryId == c.id,
                    onSelected: (_) => setState(() => _categoryId = c.id),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              isExpense ? l10n.paidFrom : l10n.receivedIn,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final w in wallets)
                  ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            context.walletName(w),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Text(' · '),
                        MoneyText(balances[w.id] ?? 0),
                      ],
                    ),
                    selected: _walletId == w.id,
                    onSelected: (_) => setState(() => _walletId = w.id),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.descriptionOptional,
                helperText: l10n.descriptionHelper,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(context.dateLabel(_date)),
              subtitle: Text(l10n.tapToChangeDate),
              onTap: _pickDate,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(isExpense ? l10n.saveExpense : l10n.saveIncome),
            ),
          ],
        ),
      ),
    );
  }
}
