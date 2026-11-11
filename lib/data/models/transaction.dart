enum TxType { expense, income }

class Transaction {
  final String id;
  final String title;
  final double amount; // always positive; sign comes from [type]
  final TxType type;
  final String categoryId;
  final String walletId;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.walletId,
    required this.date,
  });
}
