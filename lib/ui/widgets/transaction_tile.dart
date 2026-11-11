import 'package:flutter/material.dart';

import '../../core/categories.dart';
import '../../core/format.dart';
import '../../core/theme.dart';
import '../../data/models/transaction.dart';

class TransactionTile extends StatelessWidget {
  final Transaction tx;
  final String walletName;
  const TransactionTile({super.key, required this.tx, required this.walletName});

  @override
  Widget build(BuildContext context) {
    final cat = categoryById(tx.categoryId);
    final isIncome = tx.type == TxType.income;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: cat.color.withAlpha(40),
        child: Icon(cat.icon, color: cat.color),
      ),
      title: Text(tx.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${cat.name} · $walletName'),
      // Sign + color: never color alone.
      trailing: Text(
        money(isIncome ? tx.amount : -tx.amount, sign: true),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: isIncome ? incomeColor : expenseColor,
        ),
      ),
    );
  }
}
