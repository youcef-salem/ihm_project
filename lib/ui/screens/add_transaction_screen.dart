import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/categories.dart';
import '../../core/format.dart';
import '../../core/theme.dart';
import '../../data/models/transaction.dart';
import '../../state/transactions_provider.dart';
import '../../state/wallets_provider.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() => _AddTransactionScreenState();
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
    final amount = parseAmount(_amountCtrl.text)!;
    final balance = ref.read(walletBalancesProvider)[_walletId] ?? 0;

    if (_type == TxType.expense && amount > balance) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Not enough balance'),
          content: Text('This wallet only has ${money(balance)}. Save this expense anyway?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Edit')),
            FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Save anyway')),
          ],
        ),
      );
      if (ok != true) return;
    }
    if (!mounted) return;

    final cat = categoryById(_categoryId);
    final title = _titleCtrl.text.trim().isEmpty ? cat.name : _titleCtrl.text.trim();
    ref.read(transactionsProvider.notifier).add(Transaction(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          amount: amount,
          type: _type,
          categoryId: _categoryId,
          walletId: _walletId!,
          date: _date,
        ));
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(SnackBar(content: Text('Saved: $title · ${money(amount)}')));
  }

  @override
  Widget build(BuildContext context) {
    final wallets = ref.watch(walletsProvider);
    final balances = ref.watch(walletBalancesProvider);
    final scheme = Theme.of(context).colorScheme;
    final amount = parseAmount(_amountCtrl.text);
    final balance = balances[_walletId] ?? 0;
    final overdraw = _type == TxType.expense && amount != null && amount > balance;
    final isExpense = _type == TxType.expense;

    return Scaffold(
      appBar: AppBar(title: const Text('Add transaction')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(kPad),
          children: [
            SegmentedButton<TxType>(
              segments: const [
                ButtonSegment(value: TxType.expense, label: Text('Expense'), icon: Icon(Icons.arrow_upward)),
                ButtonSegment(value: TxType.income, label: Text('Income'), icon: Icon(Icons.arrow_downward)),
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
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                labelText: 'Amount',
                suffixText: 'DA',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Enter an amount';
                final a = parseAmount(v);
                if (a == null) return 'Use numbers only';
                if (a <= 0) return 'Amount must be greater than 0';
                if (a > 100000000) return 'This amount looks too large';
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
                        'More than this wallet\'s balance (${money(balance)}).',
                        style: TextStyle(color: scheme.onTertiaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text('Category', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _categories)
                  ChoiceChip(
                    avatar: Icon(c.icon, size: 18, color: c.color),
                    label: Text(c.name),
                    selected: _categoryId == c.id,
                    onSelected: (_) => setState(() => _categoryId = c.id),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(isExpense ? 'Paid from' : 'Received in', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final w in wallets)
                  ChoiceChip(
                    label: Text('${w.name} · ${money(balances[w.id] ?? 0)}'),
                    selected: _walletId == w.id,
                    onSelected: (_) => setState(() => _walletId = w.id),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                helperText: 'Left empty, the category name is used',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(dateLabel(_date)),
              subtitle: const Text('Tap to change the date'),
              onTap: _pickDate,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(isExpense ? 'Save expense' : 'Save income'),
            ),
          ],
        ),
      ),
    );
  }
}
