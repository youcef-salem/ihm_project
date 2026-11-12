import '../models/transaction.dart';

/// Income / expense totals for a single month.
class MonthSummary {
  final double income;
  final double expense;
  const MonthSummary(this.income, this.expense);

  double get net => income - expense;
  double get savingsRate => income <= 0 ? 0 : net / income;
}

bool isInMonth(DateTime date, DateTime month) =>
    date.year == month.year && date.month == month.month;

MonthSummary summarizeMonth(
  Iterable<Transaction> transactions, {
  DateTime? now,
}) {
  final month = now ?? DateTime.now();
  var income = 0.0, expense = 0.0;
  for (final t in transactions) {
    if (!isInMonth(t.date, month)) continue;
    if (t.type == TxType.income) {
      income += t.amount;
    } else {
      expense += t.amount;
    }
  }
  return MonthSummary(income, expense);
}

Map<String, double> expensesByCategory(
  Iterable<Transaction> transactions, {
  DateTime? now,
}) {
  final month = now ?? DateTime.now();
  final map = <String, double>{};
  for (final t in transactions) {
    if (t.type != TxType.expense || !isInMonth(t.date, month)) continue;
    map[t.categoryId] = (map[t.categoryId] ?? 0) + t.amount;
  }
  return map;
}
