import 'package:flutter_test/flutter_test.dart';

import 'package:efeito_fallout/main.dart';

void main() {
  testWidgets('mostra a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());

    expect(find.text('Curiosidades sobre energia nuclear'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
  });

  testWidgets('botao comecar abre a lista', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(find.text('Curiosidades'), findsOneWidget);
    expect(find.text('Chernobyl (1986)'), findsOneWidget);
  });
}
