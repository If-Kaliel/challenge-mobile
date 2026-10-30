import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:efeito_fallout/main.dart';
import 'package:efeito_fallout/servicos/leitor.dart';

// no teste nao tem voz de verdade, entao guarda o que o app mandou falar
final List<MethodCall> chamadasVoz = [];

List<String> textosFalados() {
  // no android vem um map e nos outros sistemas vem so o texto
  return chamadasVoz.where((c) => c.method == 'speak').map((c) {
    final argumentos = c.arguments;
    return (argumentos is Map ? argumentos['text'] : argumentos) as String;
  }).toList();
}

// finge um aviso que viria do Android (comecou, terminou, cancelou)
Future<void> vozAvisa(String metodo) async {
  final dados = const StandardMethodCodec().encodeMethodCall(
    MethodCall(metodo, true),
  );
  await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .handlePlatformMessage('flutter_tts', dados, (_) {});
}

// a tela padrao do teste e 800x600, ai a grade nao cabe. usa tamanho de celular
void telaDeCelular(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

// abre o app e vai ate a lista com todas as curiosidades
Future<void> abrirLista(WidgetTester tester) async {
  telaDeCelular(tester);
  await tester.pumpWidget(const EfeitoFalloutApp());
  await tester.tap(find.text('Começar'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Ver todas as curiosidades'));
  await tester.pumpAndSettle();
}

// abre o painel do botao de maozinhas e liga/desliga o modo de som
Future<void> mexerNoModoSom(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.sign_language));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Modo de som'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Fechar'));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    chamadasVoz.clear();
    Leitor.modoSom.value = false;
    Leitor.falandoAgora.value = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), (
          chamada,
        ) async {
          chamadasVoz.add(chamada);
          return 1;
        });
  });

  testWidgets('mostra a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());

    expect(find.text('EFEITO FALLOUT'), findsOneWidget);
    expect(find.textContaining('Curiosidades sobre energia nuclear'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
  });

  testWidgets('botao comecar abre as categorias', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(find.text('Explorar'), findsOneWidget);
    expect(find.text('Tragédias'), findsOneWidget);
    expect(find.text('Medicina'), findsOneWidget);
    expect(find.text('Energia'), findsOneWidget);
    expect(find.text('Ciência'), findsOneWidget);
  });

  testWidgets('abre a tela sobre', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());

    await tester.tap(find.text('Sobre o app'));
    await tester.pumpAndSettle();

    expect(find.text('Empresa parceira: AMAZUL'), findsOneWidget);
  });

  testWidgets('categoria filtra a lista', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Medicina'));
    await tester.pumpAndSettle();

    expect(find.text('Exame PET'), findsOneWidget);
    expect(find.text('Chernobyl (1986)'), findsNothing);
  });

  testWidgets('ver todas mostra a lista inteira', (WidgetTester tester) async {
    await abrirLista(tester);

    expect(find.text('Curiosidades'), findsOneWidget);
    expect(find.text('Chernobyl (1986)'), findsOneWidget);
  });

  testWidgets('clicar na curiosidade abre os detalhes', (WidgetTester tester) async {
    await abrirLista(tester);

    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();

    expect(find.text('Detalhes'), findsOneWidget);
    expect(find.textContaining('zona de exclusão'), findsOneWidget);
  });

  testWidgets('favoritar muda o contador', (WidgetTester tester) async {
    await abrirLista(tester);

    expect(find.text('Favoritos: 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.text('Favoritos: 1'), findsOneWidget);

    // clicar de novo desfavorita
    await tester.tap(find.byIcon(Icons.favorite).at(1));
    await tester.pump();
    expect(find.text('Favoritos: 0'), findsOneWidget);
  });

  testWidgets('favorito continua quando troca de categoria', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tragédias'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Medicina'));
    await tester.pumpAndSettle();
    expect(find.text('Favoritos: 1'), findsOneWidget);
  });

  testWidgets('tela de favoritos mostra e remove', (WidgetTester tester) async {
    await abrirLista(tester);

    // sem favoritos
    await tester.tap(find.text('ver'));
    await tester.pumpAndSettle();
    expect(find.text('Você ainda não favoritou nada'), findsOneWidget);
    await tester.tap(find.byTooltip('Voltar'));
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
    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    expect(find.text('Favoritos: 0'), findsOneWidget);
  });

  testWidgets('formulario vazio mostra os erros', (WidgetTester tester) async {
    await abrirLista(tester);

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
    await abrirLista(tester);
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

  testWidgets('botao ouvir le a curiosidade e vira parar', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ouvir'));
    await tester.pumpAndSettle();

    expect(textosFalados(), hasLength(1));
    expect(textosFalados().first, contains('Chernobyl (1986)'));
    expect(textosFalados().first, contains('Foto: Pripyat abandonada'));
    expect(textosFalados().first, contains('zona de exclusão'));

    await vozAvisa('speak.onStart');
    await tester.pump();
    expect(find.text('Parar'), findsOneWidget);

    await tester.tap(find.text('Parar'));
    await tester.pumpAndSettle();
    expect(chamadasVoz.where((c) => c.method == 'stop'), isNotEmpty);

    await vozAvisa('speak.onCancel');
    await tester.pump();
    expect(find.text('Ouvir'), findsOneWidget);
  });

  testWidgets('botao volta pra ouvir quando a fala termina', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Césio-137 em Goiânia (1987)'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ouvir'));
    await tester.pumpAndSettle();
    await vozAvisa('speak.onStart');
    await tester.pump();
    expect(find.text('Parar'), findsOneWidget);

    await vozAvisa('speak.onComplete');
    await tester.pump();
    expect(find.text('Ouvir'), findsOneWidget);
  });

  testWidgets('cancelar a fala antiga nao apaga a fala nova', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ouvir'));
    await tester.pumpAndSettle();
    await vozAvisa('speak.onStart');
    await tester.pump();

    // o android avisa nessa ordem quando uma fala corta a outra
    await vozAvisa('speak.onCancel');
    await vozAvisa('speak.onStart');
    await tester.pump();

    expect(find.text('Parar'), findsOneWidget);
  });

  testWidgets('sair da tela para de falar', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ouvir'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();

    expect(chamadasVoz.where((c) => c.method == 'stop'), isNotEmpty);
  });

  testWidgets('modo de som ligado le as telas sozinho', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());

    await mexerNoModoSom(tester);
    expect(textosFalados().last, 'Modo de som ligado');

    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    expect(textosFalados().last, contains('Explorar'));
    expect(textosFalados().last, contains('Tragédias'));

    await tester.tap(find.text('Medicina'));
    await tester.pumpAndSettle();
    expect(textosFalados().last, contains('Exame PET'));

    await tester.tap(find.text('Exame PET'));
    await tester.pumpAndSettle();
    expect(textosFalados().last, contains('Foto: Exame PET do cérebro'));
  });

  testWidgets('modo de som desligado nao fala nada', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();

    expect(textosFalados(), isEmpty);
  });

  testWidgets('botao de maozinhas aparece em todas as telas', (WidgetTester tester) async {
    await abrirLista(tester);
    expect(find.byIcon(Icons.sign_language), findsOneWidget);

    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.sign_language), findsOneWidget);
  });

  testWidgets('painel liga e desliga o modo de som', (WidgetTester tester) async {
    await abrirLista(tester);

    await mexerNoModoSom(tester);
    expect(Leitor.modoSom.value, isTrue);

    await mexerNoModoSom(tester);
    expect(Leitor.modoSom.value, isFalse);
    expect(chamadasVoz.where((c) => c.method == 'stop'), isNotEmpty);
  });

  testWidgets('painel nao abre duas vezes', (WidgetTester tester) async {
    await abrirLista(tester);

    await tester.tap(find.byIcon(Icons.sign_language));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.sign_language), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text('Fechar'), findsOneWidget);
  });

  testWidgets('talkback ligado o app nao fala por cima', (WidgetTester tester) async {
    telaDeCelular(tester);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(accessibleNavigation: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    Leitor.modoSom.value = true;

    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(textosFalados(), isEmpty);
  });

  testWidgets('botoes e fotos tem descricao pro talkback', (WidgetTester tester) async {
    final semantica = tester.ensureSemantics();
    await abrirLista(tester);

    expect(find.byTooltip('Favoritar Chernobyl (1986)'), findsOneWidget);
    await tester.tap(find.byTooltip('Favoritar Chernobyl (1986)'));
    await tester.pump();
    expect(find.byTooltip('Remover Chernobyl (1986) dos favoritos'), findsOneWidget);

    expect(find.bySemanticsLabel(RegExp('Favoritos: 1')), findsOneWidget);

    // o botao tem que ser um item pequeno, nao a tela inteira
    final botao = tester.getSemantics(find.bySemanticsLabel('Acessibilidade'));
    expect(botao.rect.width, lessThan(100));
    expect(botao, isSemantics(isButton: true));

    // a seta de voltar tem que estar em portugues
    expect(find.byTooltip('Voltar'), findsOneWidget);

    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel(RegExp('^Foto: Pripyat abandonada')), findsOneWidget);

    semantica.dispose();
  });

  testWidgets('telas aguentam fonte grande', (WidgetTester tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());

    // com fonte grande a tela inicial rola e tudo continua alcancavel
    await tester.ensureVisible(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Ver todas as curiosidades'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
