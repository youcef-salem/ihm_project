import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/categories.dart';
import '../core/l10n.dart';
import '../data/calculations/transactions.dart';
import '../data/models/transaction.dart';
import 'mock_seed.dart';
import 'settings_provider.dart';

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
    NotifierProvider<TransactionsNotifier, List<Transaction>>(
      TransactionsNotifier.new,
    );

// Transactions screen: filter + search.
final txFilterProvider = StateProvider<TxType?>((ref) => null);
final txSearchProvider = StateProvider<String>((ref) => '');

final filteredTransactionsProvider = Provider<List<Transaction>>((ref) {
  final locale = ref.watch(settingsProvider.select((s) => s.locale));
  final l10n = l10nFor(locale);
  return filterTransactions(
    ref.watch(transactionsProvider),
    type: ref.watch(txFilterProvider),
    query: ref.watch(txSearchProvider),
    categoryName: (id) => categoryName(l10n, id),
  );
});
