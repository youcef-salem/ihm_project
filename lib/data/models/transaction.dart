enum TxType { expense, income }

class Transaction {
  final String id;
  final String title;
  final double amount; // always positive; sign comes from [type]
  final TxType type;
  final String categoryId;
  final String walletId;
  final DateTime date;

  /// Set once at entry time: this expense was flagged as unusually large
  /// compared to the user's average for its category. Never recomputed.
  final bool isUnusual;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.walletId,
    required this.date,
    this.isUnusual = false,
  });

  Transaction copyWith({bool? isUnusual}) => Transaction(
    id: id,
    title: title,
    amount: amount,
    type: type,
    categoryId: categoryId,
    walletId: walletId,
    date: date,
    isUnusual: isUnusual ?? this.isUnusual,
  );
}
