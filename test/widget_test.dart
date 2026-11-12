import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ihm_ui/app.dart';

void main() {
  testWidgets('app starts on the home tab', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: EcoBudgetApp()));

    expect(find.text('Accueil'), findsWidgets);
  });
}
