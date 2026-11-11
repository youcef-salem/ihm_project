import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/theme.dart';
import '../../data/models/transaction.dart';
import '../../state/transactions_provider.dart';
import '../../state/wallets_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(filteredTransactionsProvider);
    final filter = ref.watch(txFilterProvider);
    final names = {for (final w in ref.watch(walletsProvider)) w.id: w.name};
    final scheme = Theme.of(context).colorScheme;

    // Flatten into date headers + transactions.
    final items = <Object>[];
    String? last;
    for (final t in list) {
      final label = dateLabel(t.date);
      if (label != last) {
        items.add(label);
        last = label;
      }
      items.add(t);
    }

    void setFilter(TxType? v) => ref.read(txFilterProvider.notifier).state = v;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(kPad, kPad, kPad, 8),
          child: TextField(
            onChanged: (v) => ref.read(txSearchProvider.notifier).state = v,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search by title or category',
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPad),
          child: Row(
            children: [
              ChoiceChip(label: const Text('All'), selected: filter == null, onSelected: (_) => setFilter(null)),
              const SizedBox(width: 8),
              ChoiceChip(label: const Text('Expenses'), selected: filter == TxType.expense, onSelected: (_) => setFilter(TxType.expense)),
              const SizedBox(width: 8),
              ChoiceChip(label: const Text('Income'), selected: filter == TxType.income, onSelected: (_) => setFilter(TxType.income)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(kPad, 8, kPad, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Swipe a transaction left to delete it',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const EmptyState(
                  icon: Icons.search_off,
                  title: 'Nothing found',
                  message: 'Try another search or filter.',
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    if (item is String) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(kPad, 16, kPad, 4),
                        child: Text(item,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: scheme.primary)),
                      );
                    }
                    final tx = item as Transaction;
                    return Dismissible(
                      key: ValueKey(tx.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: scheme.errorContainer,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 24),
                        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
                      ),
                      onDismissed: (_) {
                        ref.read(transactionsProvider.notifier).remove(tx.id);
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(SnackBar(
                            content: Text('Deleted "${tx.title}"'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () => ref.read(transactionsProvider.notifier).add(tx),
                            ),
                          ));
                      },
                      child: TransactionTile(tx: tx, walletName: names[tx.walletId] ?? '-'),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
