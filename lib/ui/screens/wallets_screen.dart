import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/l10n.dart';
import '../../core/theme.dart';
import '../../core/wallet_kinds.dart';
import '../../data/models/wallet.dart';
import '../../state/wallets_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/money_text.dart';

class WalletsScreen extends ConsumerWidget {
  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final wallets = ref.watch(walletsProvider);
    final balances = ref.watch(walletBalancesProvider);
    final total = ref.watch(totalBalanceProvider);
    final t = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(kPad, kPad, kPad, 96),
      children: [
        Card(
          color: t.colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(kPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.totalAcrossWallets,
                  style: TextStyle(color: t.colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 4),
                MoneyText(
                  total,
                  style: t.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: t.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          icon: const Icon(Icons.add),
          label: Text(l10n.addWallet),
          onPressed: () async {
            final w = await showDialog<Wallet>(
              context: context,
              builder: (_) => const _NewWalletDialog(),
            );
            if (w != null) ref.read(walletsProvider.notifier).add(w);
          },
        ),
        const SizedBox(height: 12),
        if (wallets.isEmpty)
          EmptyState(
            icon: Icons.account_balance_wallet_outlined,
            title: l10n.noWalletsTitle,
            message: l10n.noWalletsMessage,
          )
        else
          for (final w in wallets)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: t.colorScheme.secondaryContainer,
                  child: Icon(
                    walletKindIcon(w.kind),
                    color: t.colorScheme.onSecondaryContainer,
                  ),
                ),
                title: Text(context.walletName(w)),
                subtitle: Text(walletKindLabel(l10n, w.kind)),
                trailing: MoneyText(
                  balances[w.id] ?? 0,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
      ],
    );
  }
}

class _NewWalletDialog extends StatefulWidget {
  const _NewWalletDialog();

  @override
  State<_NewWalletDialog> createState() => _NewWalletDialogState();
}

class _NewWalletDialogState extends State<_NewWalletDialog> {
  final _name = TextEditingController();
  final _balance = TextEditingController(text: '0');
  WalletKind _kind = WalletKind.cash;
  String? _nameError;
  String? _balanceError;

  @override
  void dispose() {
    _name.dispose();
    _balance.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = context.l10n;
    final name = _name.text.trim();
    final bal = parseAmount(_balance.text);
    setState(() {
      _nameError = name.isEmpty ? l10n.giveWalletName : null;
      _balanceError = bal == null ? l10n.numbersOnly : null;
    });
    if (_nameError != null || _balanceError != null) return;
    Navigator.pop(
      context,
      Wallet(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        kind: _kind,
        initialBalance: bal!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.newWallet),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _name,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.name,
                errorText: _nameError,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _balance,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.currentBalance,
                suffixText: l10n.currency,
                errorText: _balanceError,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final k in WalletKind.values)
                  ChoiceChip(
                    avatar: Icon(walletKindIcon(k), size: 18),
                    label: Text(walletKindLabel(l10n, k)),
                    selected: _kind == k,
                    onSelected: (_) => setState(() => _kind = k),
                  ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.add)),
      ],
    );
  }
}
