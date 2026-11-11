import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/categories.dart';
import '../core/format.dart';
import '../data/models/transaction.dart';
import 'budget_provider.dart';
import 'summary_provider.dart';
import 'transactions_provider.dart';

enum InsightKind { unusual, budget, tip }

class Insight {
  final String id;
  final InsightKind kind;
  final String title;
  final String message;
  const Insight(this.id, this.kind, this.title, this.message);
}

/// Insights the user closed (explicit control).
class DismissedInsightsNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void dismiss(String id) => state = {...state, id};
}

final dismissedInsightsProvider =
    NotifierProvider<DismissedInsightsNotifier, Set<String>>(DismissedInsightsNotifier.new);

/// INNOVATION: unusual-spending detection + budget alerts + savings tip.
final insightsProvider = Provider<List<Insight>>((ref) {
  final txs = ref.watch(transactionsProvider);
  final budget = ref.watch(budgetProvider);
  final spent = ref.watch(monthExpensesByCategoryProvider);
  final summary = ref.watch(monthSummaryProvider);
  final dismissed = ref.watch(dismissedInsightsProvider);

  final now = DateTime.now();
  final monthKey = '${now.year}${now.month}';
  final out = <Insight>[];
  final expenses = txs.where((t) => t.type == TxType.expense).toList();

  // 1) Unusual expense: this month, > 2.5x the average of earlier ones in the same category.
  for (final t in expenses) {
    if (t.date.year != now.year || t.date.month != now.month) continue;
    final earlier = expenses
        .where((o) => o.id != t.id && o.categoryId == t.categoryId && o.date.isBefore(t.date))
        .toList();
    if (earlier.length < 3) continue;
    final avg = earlier.fold(0.0, (s, o) => s + o.amount) / earlier.length;
    if (avg > 0 && t.amount > avg * 2.5) {
      final cat = categoryById(t.categoryId);
      out.add(Insight(
        'unusual_${t.id}',
        InsightKind.unusual,
        'Unusual ${cat.name.toLowerCase()} expense',
        '"${t.title}" (${money(t.amount)}) is ${(t.amount / avg).toStringAsFixed(1)}x '
            'your usual ${cat.name.toLowerCase()} expense (about ${money(avg)}).',
      ));
    }
  }

  // 2) Budget alerts at 80%+.
  for (final e in budget.entries) {
    if (e.value <= 0) continue;
    final used = spent[e.key] ?? 0;
    final ratio = used / e.value;
    if (ratio < 0.8) continue;
    final cat = categoryById(e.key);
    out.add(Insight(
      'budget_${e.key}_$monthKey',
      InsightKind.budget,
      ratio >= 1
          ? '${cat.name} budget exceeded'
          : '${cat.name} budget ${(ratio * 100).round()}% used',
      ratio >= 1
          ? 'You are ${money(used - e.value)} over your ${money(e.value)} limit.'
          : 'Only ${money(e.value - used)} left this month.',
    ));
  }

  // 3) Savings tip.
  if (summary.income > 0 && summary.savingsRate < 0.1) {
    out.add(Insight(
      'tip_savings_$monthKey',
      InsightKind.tip,
      'Low savings this month',
      'You kept ${(summary.savingsRate * 100).round()}% of your income. '
          'Aim for at least 10%: lower a flexible budget such as Leisure or Shopping.',
    ));
  }

  out.sort((a, b) => a.kind.index.compareTo(b.kind.index));
  return out.where((i) => !dismissed.contains(i.id)).take(4).toList();
});
