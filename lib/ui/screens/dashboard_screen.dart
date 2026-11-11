import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme.dart';
import '../../state/insights_provider.dart';
import '../../state/nav_provider.dart';
import '../../state/summary_provider.dart';
import '../../state/transactions_provider.dart';
import '../../state/wallets_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/category_donut.dart';
import '../widgets/empty_state.dart';
import '../widgets/insight_card.dart';
import '../widgets/section_header.dart';
import '../widgets/transaction_tile.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalBalanceProvider);
    final summary = ref.watch(monthSummaryProvider);
    final insights = ref.watch(insightsProvider);
    final spent = ref.watch(monthExpensesByCategoryProvider);
    final txs = ref.watch(transactionsProvider);
    final names = {for (final w in ref.watch(walletsProvider)) w.id: w.name};

    return ListView(
      padding: const EdgeInsets.fromLTRB(kPad, kPad, kPad, 96),
      children: [
        BalanceCard(total: total, summary: summary),
        if (insights.isNotEmpty) ...[
          const SizedBox(height: 20),
          const SectionHeader('Smart insights'),
          for (final i in insights)
            InsightCard(
              insight: i,
              onDismiss: () => ref.read(dismissedInsightsProvider.notifier).dismiss(i.id),
            ),
        ],
        const SizedBox(height: 20),
        const SectionHeader('Spending this month'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(kPad),
            child: CategoryDonut(data: spent),
          ),
        ),
        const SizedBox(height: 20),
        SectionHeader(
          'Recent',
          trailing: TextButton(
            onPressed: () => ref.read(tabIndexProvider.notifier).state = 1,
            child: const Text('See all'),
          ),
        ),
        if (txs.isEmpty)
          const EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'No transactions yet',
            message: 'Tap "Add" to record your first expense or income.',
          )
        else
          for (final t in txs.take(5))
            TransactionTile(tx: t, walletName: names[t.walletId] ?? '-'),
      ],
    );
  }
}
