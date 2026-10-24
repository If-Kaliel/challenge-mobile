import 'package:flutter/material.dart';
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

  testWidgets('clicar na curiosidade abre os detalhes', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();

    expect(find.text('Detalhes'), findsOneWidget);
    expect(find.textContaining('Pripyat'), findsOneWidget);
  });

  testWidgets('favoritar muda o contador', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(find.text('Favoritos: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.text('Favoritos: 1'), findsOneWidget);

    // clicar de novo desfavorita
    await tester.tap(find.byIcon(Icons.favorite).at(1));
    await tester.pump();
    expect(find.text('Favoritos: 0'), findsOneWidget);
  });

  testWidgets('tela de favoritos mostra e remove', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    // sem favoritos
    await tester.tap(find.text('ver'));
    await tester.pumpAndSettle();
    expect(find.text('Você ainda não favoritou nada'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // favorita o primeiro e abre
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    await tester.tap(find.text('ver'));
    await tester.pumpAndSettle();
    expect(find.text('Meus favoritos'), findsOneWidget);
    expect(find.text('Chernobyl (1986)'), findsOneWidget);

    // remove e volta, o contador tem que zerar
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();
    expect(find.text('Você ainda não favoritou nada'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Favoritos: 0'), findsOneWidget);
  });

  testWidgets('formulario vazio mostra os erros', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Enviar'));
    await tester.tap(find.text('Enviar'));
    await tester.pump();

    expect(find.text('Digite seu nome'), findsOneWidget);
    expect(find.text('Digite seu e-mail'), findsOneWidget);
    expect(find.text('Escolha uma categoria'), findsOneWidget);
    expect(find.text('Escreva o que você ouviu'), findsOneWidget);
  });

  testWidgets('formulario certo mostra o dialog e volta pra lista', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Nome'), 'Joao Silva');
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), 'joao@email.com');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'O que você ouviu?'),
      'Quem mora perto de usina fica radioativo',
    );

    await tester.tap(find.text('Categoria'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Energia').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Enviar'));
    await tester.tap(find.text('Enviar'));
    await tester.pumpAndSettle();

    expect(find.text('Enviado!'), findsOneWidget);
    expect(find.textContaining('Valeu, Joao!'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Curiosidades'), findsOneWidget);
  });
}
