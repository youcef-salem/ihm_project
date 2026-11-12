import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calculations/wallets.dart';
import '../data/models/wallet.dart';
import 'mock_seed.dart';
import 'transactions_provider.dart';

class WalletsNotifier extends Notifier<List<Wallet>> {
  @override
  List<Wallet> build() => seedWallets();

  void add(Wallet w) => state = [...state, w];
}

final walletsProvider = NotifierProvider<WalletsNotifier, List<Wallet>>(
  WalletsNotifier.new,
);

/// Current balance per wallet = initial + income - expenses.
final walletBalancesProvider = Provider<Map<String, double>>((ref) {
  return calculateWalletBalances(
    ref.watch(walletsProvider),
    ref.watch(transactionsProvider),
  );
});

final totalBalanceProvider = Provider<double>(
  (ref) => calculateTotalBalance(ref.watch(walletBalancesProvider).values),
);
