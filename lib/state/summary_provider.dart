import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calculations/summary.dart';
import 'transactions_provider.dart';

export '../data/calculations/summary.dart' show MonthSummary;

final monthSummaryProvider = Provider<MonthSummary>((ref) {
  return summarizeMonth(ref.watch(transactionsProvider));
});

final monthExpensesByCategoryProvider = Provider<Map<String, double>>((ref) {
  return expensesByCategory(ref.watch(transactionsProvider));
});
