import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ihm_ui/ui/screens/add_transaction_screen.dart';

void main() {
  testWidgets('overdraw hint tracks the amount against the wallet balance', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: AddTransactionScreen())),
    );

    final amountField = find.byType(TextFormField).first;

    await tester.enterText(amountField, '100');
    await tester.pump();
    expect(find.textContaining('more than the wallet balance'), findsNothing);

    await tester.enterText(amountField, '30000');
    await tester.pump();
    expect(find.textContaining('more than the wallet balance'), findsOneWidget);
  });
}
