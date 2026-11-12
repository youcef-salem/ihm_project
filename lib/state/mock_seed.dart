// In-memory seed data (no backend: everything lives in app state).
import '../data/models/transaction.dart';
import '../data/models/wallet.dart';

List<Wallet> seedWallets() => const [
  Wallet(
    id: 'w_cash',
    name: 'Cash',
    kind: WalletKind.cash,
    initialBalance: 50000,
  ),
  Wallet(
    id: 'w_ccp',
    name: 'CCP Account',
    kind: WalletKind.bank,
    initialBalance: 55000,
  ),
  Wallet(
    id: 'w_card',
    name: 'Bank Card',
    kind: WalletKind.card,
    initialBalance: 80000,
  ),
];

List<Transaction> seedTransactions() {
  final now = DateTime.now();
  final base = DateTime(now.year, now.month, now.day);
  var n = 0;
  Transaction t(
    String title,
    double amount,
    String cat,
    int daysAgo, {
    TxType type = TxType.expense,
    String wallet = 'w_cash',
  }) => Transaction(
    id: 'seed_${n++}',
    title: title,
    amount: amount,
    type: type,
    categoryId: cat,
    walletId: wallet,
    date: base.subtract(Duration(days: daysAgo)),
  );

  final list = <Transaction>[
    t('Salary', 62000, 'salary', 9, type: TxType.income, wallet: 'w_ccp'),
    t(
      'Freelance logo',
      15000,
      'freelance',
      5,
      type: TxType.income,
      wallet: 'w_card',
    ),
    t('Salary', 62000, 'salary', 39, type: TxType.income, wallet: 'w_ccp'),
    t('Groceries', 4200, 'food', 1),
    t('Lunch', 900, 'food', 3),
    t('Groceries', 5100, 'food', 7, wallet: 'w_card'),
    t('Tram + bus', 1200, 'transport', 2),
    t('Taxi', 1800, 'transport', 6),
    t('Electricity bill', 4800, 'bills', 8, wallet: 'w_ccp'),
    t('Internet', 3000, 'bills', 10, wallet: 'w_ccp'),
    t('New phone (unplanned)', 38000, 'shopping', 2, wallet: 'w_card'),
    t('T-shirt', 4500, 'shopping', 12, wallet: 'w_card'),
    t('Shoes', 3200, 'shopping', 22, wallet: 'w_card'),
    t('Bag', 5200, 'shopping', 33, wallet: 'w_card'),
    t('Jacket', 3900, 'shopping', 45, wallet: 'w_card'),
    t('Pharmacy', 1500, 'health', 4),
    t('Cinema', 1200, 'leisure', 6),
    t('Online course', 3500, 'education', 11, wallet: 'w_card'),
    t('Groceries', 6000, 'food', 15),
    t('Groceries', 4800, 'food', 28),
  ];
  list.sort((a, b) => b.date.compareTo(a.date));
  return list;
}
