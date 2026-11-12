import '../models/transaction.dart';
import '../models/wallet.dart';

/// Current balance per wallet = initial + income - expenses.
Map<String, double> calculateWalletBalances(
  Iterable<Wallet> wallets,
  Iterable<Transaction> transactions,
) {
  final map = <String, double>{for (final w in wallets) w.id: w.initialBalance};
  for (final t in transactions) {
    final current = map[t.walletId];
    if (current == null) continue;
    map[t.walletId] =
        current + (t.type == TxType.income ? t.amount : -t.amount);
  }
  return map;
}

double calculateTotalBalance(Iterable<double> balances) =>
    balances.fold(0.0, (a, b) => a + b);

/// Amount by which [amount] exceeds [balance] (0 when it fits).
double walletShortfall(double balance, double amount) =>
    amount > balance ? amount - balance : 0;
