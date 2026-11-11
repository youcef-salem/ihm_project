import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/categories.dart';
import '../data/models/transaction.dart';
import 'mock_seed.dart';

class TransactionsNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() => seedTransactions();

  void add(Transaction t) {
    final next = [t, ...state]..sort((a, b) => b.date.compareTo(a.date));
    state = next;
  }

  void remove(String id) => state = state.where((t) => t.id != id).toList();
}

final transactionsProvider =
    NotifierProvider<TransactionsNotifier, List<Transaction>>(TransactionsNotifier.new);

// Transactions screen: filter + search.
final txFilterProvider = StateProvider<TxType?>((ref) => null);
final txSearchProvider = StateProvider<String>((ref) => '');

final filteredTransactionsProvider = Provider<List<Transaction>>((ref) {
  final all = ref.watch(transactionsProvider);
  final filter = ref.watch(txFilterProvider);
  final q = ref.watch(txSearchProvider).trim().toLowerCase();
  return all.where((t) {
    if (filter != null && t.type != filter) return false;
    if (q.isEmpty) return true;
    return t.title.toLowerCase().contains(q) ||
        categoryById(t.categoryId).name.toLowerCase().contains(q);
  }).toList();
});
