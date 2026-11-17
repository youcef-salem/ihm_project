import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calculations/summary.dart';
import '../data/models/transaction.dart';
import 'transactions_provider.dart';

export '../data/calculations/summary.dart' show MonthSummary;

final monthSummaryProvider = Provider<MonthSummary>((ref) {
  return summarizeMonth(ref.watch(transactionsProvider));
});

final monthExpensesByCategoryProvider = Provider<Map<String, double>>((ref) {
  return expensesByCategory(ref.watch(transactionsProvider));
});

/// Unusual expenses flagged at entry time, most recent first (this month).
final unusualThisMonthProvider = Provider<List<Transaction>>((ref) {
  final now = DateTime.now();
  final list = ref
      .watch(transactionsProvider)
      .where((t) => t.isUnusual && isInMonth(t.date, now))
      .toList();
  list.sort((a, b) => b.date.compareTo(a.date));
  return list;
});
