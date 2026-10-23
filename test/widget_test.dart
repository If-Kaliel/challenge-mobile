import 'package:flutter_test/flutter_test.dart';

import 'package:efeito_fallout/main.dart';

void main() {
  testWidgets('mostra a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());

    expect(find.text('Curiosidades sobre energia nuclear'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
  });
}
