import 'package:flutter_test/flutter_test.dart';

import 'package:ihm_ui/data/calculations/unusual.dart';
import 'package:ihm_ui/data/models/transaction.dart';

Transaction _tx(
  double amount, {
  TxType type = TxType.expense,
  String categoryId = 'food',
}) => Transaction(
  id: 'tx_${amount}_$categoryId',
  title: 'Tx',
  amount: amount,
  type: type,
  categoryId: categoryId,
  walletId: 'w_cash',
  date: DateTime(2026, 11, 10),
);

// food history: 1000, 2000, 3000 -> mean 2000; transport: 1 sample
final history = <Transaction>[
  _tx(1000),
  _tx(2000),
  _tx(3000),
  _tx(500, categoryId: 'transport'),
];

void main() {
  test('flags an expense more than twice the category average', () {
    expect(isUnusualExpense(history, _tx(4500)), isTrue);
  });

  test('does not flag an expense at exactly twice the category average', () {
    expect(isUnusualExpense(history, _tx(4000)), isFalse);
  });

  test('does not flag an expense below twice the category average', () {
    expect(isUnusualExpense(history, _tx(2500)), isFalse);
  });

  test('requires at least two past expenses in the category', () {
    // Only one transport sample: not enough to flag.
    expect(
      isUnusualExpense([
        _tx(500, categoryId: 'transport'),
      ], _tx(99999, categoryId: 'transport')),
      isFalse,
    );
    // Two transport samples (1200, 1800 -> mean 1500): 5000 is more than 2x.
    expect(
      isUnusualExpense([
        _tx(1200, categoryId: 'transport'),
        _tx(1800, categoryId: 'transport'),
      ], _tx(5000, categoryId: 'transport')),
      isTrue,
    );
  });

  test('compares against the same category only', () {
    expect(isUnusualExpense(history, _tx(99999, categoryId: 'bills')), isFalse);
  });

  test('income is never flagged', () {
    expect(isUnusualExpense(history, _tx(99999, type: TxType.income)), isFalse);
  });

  test('handles a zero average without dividing by zero', () {
    final zeroHistory = [_tx(0), _tx(0), _tx(0)];
    expect(isUnusualExpense(zeroHistory, _tx(100)), isFalse);
  });
}
