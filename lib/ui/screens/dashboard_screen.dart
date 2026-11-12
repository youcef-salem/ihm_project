import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n.dart';
import '../../core/theme.dart';
import '../../state/nav_provider.dart';
import '../../state/summary_provider.dart';
import '../../state/transactions_provider.dart';
import '../../state/wallets_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/category_donut.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_header.dart';
import '../widgets/transaction_tile.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final total = ref.watch(totalBalanceProvider);
    final summary = ref.watch(monthSummaryProvider);
    final spent = ref.watch(monthExpensesByCategoryProvider);
    final txs = ref.watch(transactionsProvider);
    final names = {
      for (final w in ref.watch(walletsProvider)) w.id: context.walletName(w),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(kPad, kPad, kPad, 96),
      children: [
        BalanceCard(total: total, summary: summary),
        const SizedBox(height: 20),
        SectionHeader(l10n.spendingThisMonth),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(kPad),
            child: CategoryDonut(data: spent),
          ),
        ),
        const SizedBox(height: 20),
        SectionHeader(
          l10n.recent,
          trailing: TextButton(
            onPressed: () => ref.read(tabIndexProvider.notifier).state = 1,
            child: Text(l10n.seeAll),
          ),
        ),
        if (txs.isEmpty)
          EmptyState(
            icon: Icons.receipt_long_outlined,
            title: l10n.noTransactionsTitle,
            message: l10n.noTransactionsMessage,
          )
        else
          for (final t in txs.take(5))
            TransactionTile(tx: t, walletName: names[t.walletId] ?? '-'),
      ],
    );
  }
}
