import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/transaction.dart';
import '../data/models/wallet.dart';
import 'mock_seed.dart';
import 'transactions_provider.dart';

class WalletsNotifier extends Notifier<List<Wallet>> {
  @override
  List<Wallet> build() => seedWallets();

  void add(Wallet w) => state = [...state, w];
}

final walletsProvider =
    NotifierProvider<WalletsNotifier, List<Wallet>>(WalletsNotifier.new);

/// Current balance per wallet = initial + income - expenses.
final walletBalancesProvider = Provider<Map<String, double>>((ref) {
  final wallets = ref.watch(walletsProvider);
  final txs = ref.watch(transactionsProvider);
  final map = <String, double>{for (final w in wallets) w.id: w.initialBalance};
  for (final t in txs) {
    if (!map.containsKey(t.walletId)) continue;
    map[t.walletId] =
        map[t.walletId]! + (t.type == TxType.income ? t.amount : -t.amount);
  }
  return map;
});

final totalBalanceProvider = Provider<double>(
  (ref) => ref.watch(walletBalancesProvider).values.fold(0.0, (a, b) => a + b),
);
