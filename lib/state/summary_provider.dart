import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/transaction.dart';
import 'transactions_provider.dart';

class MonthSummary {
  final double income;
  final double expense;
  const MonthSummary(this.income, this.expense);

  double get net => income - expense;
  double get savingsRate => income <= 0 ? 0 : net / income;
}

bool _isThisMonth(DateTime d) {
  final now = DateTime.now();
  return d.year == now.year && d.month == now.month;
}

final monthSummaryProvider = Provider<MonthSummary>((ref) {
  var income = 0.0, expense = 0.0;
  for (final t in ref.watch(transactionsProvider)) {
    if (!_isThisMonth(t.date)) continue;
    if (t.type == TxType.income) {
      income += t.amount;
    } else {
      expense += t.amount;
    }
  }
  return MonthSummary(income, expense);
});

final monthExpensesByCategoryProvider = Provider<Map<String, double>>((ref) {
  final map = <String, double>{};
  for (final t in ref.watch(transactionsProvider)) {
    if (t.type != TxType.expense || !_isThisMonth(t.date)) continue;
    map[t.categoryId] = (map[t.categoryId] ?? 0) + t.amount;
  }
  return map;
});
