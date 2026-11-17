import '../models/transaction.dart';

const int kMinCategorySamples = 2;
const double kUnusualMultiplier = 2.0;

double? categoryExpenseMean(Iterable<Transaction> history, String categoryId) {
  var sum = 0.0, n = 0;
  for (final t in history) {
    if (t.type != TxType.expense || t.categoryId != categoryId) continue;
    sum += t.amount;
    n++;
  }
  return n >= kMinCategorySamples ? sum / n : null;
}

/// [candidate] / your average for its category, or null when not computable.
double? unusualRatioVsAverage(
  Iterable<Transaction> history,
  Transaction candidate,
) {
  if (candidate.type != TxType.expense) return null;
  final mean = categoryExpenseMean(history, candidate.categoryId);
  if (mean == null || mean <= 0) return null;
  return candidate.amount / mean;
}

/// True when [candidate] is an expense more than [kUnusualMultiplier] times
/// the user's average for that category. Needs [kMinCategorySamples] prior
/// expenses in the category; only computed once, at entry time.
bool isUnusualExpense(Iterable<Transaction> history, Transaction candidate) {
  final ratio = unusualRatioVsAverage(history, candidate);
  return ratio != null && ratio > kUnusualMultiplier;
}
