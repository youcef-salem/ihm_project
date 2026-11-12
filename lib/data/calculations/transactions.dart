import '../models/transaction.dart';

/// Filter by type and search by title or category name.
List<Transaction> filterTransactions(
  Iterable<Transaction> transactions, {
  TxType? type,
  String query = '',
  String Function(String categoryId)? categoryName,
}) {
  final q = query.trim().toLowerCase();
  return transactions.where((t) {
    if (type != null && t.type != type) return false;
    if (q.isEmpty) return true;
    if (t.title.toLowerCase().contains(q)) return true;
    final name = categoryName?.call(t.categoryId) ?? t.categoryId;
    return name.toLowerCase().contains(q);
  }).toList();
}
