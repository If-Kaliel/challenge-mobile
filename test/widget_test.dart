import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:efeito_fallout/dados/perguntas.dart';
import 'package:efeito_fallout/main.dart';
import 'package:efeito_fallout/models/pergunta.dart';
import 'package:efeito_fallout/telas/tela_resultado.dart';

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

// abre o app e vai ate o quiz
Future<void> abrirQuiz(WidgetTester tester) async {
  telaDeCelular(tester);
  await tester.pumpWidget(const EfeitoFalloutApp());
  await tester.tap(find.text('Começar'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Mito ou verdade? Faça o quiz'));
  await tester.pumpAndSettle();
}

// a explicacao empurra o botao pra baixo, entao rola ate ele antes de tocar
Future<void> tocarProxima(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Próxima'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Próxima'));
  await tester.pumpAndSettle();
}

// as perguntas vem sorteadas, entao descobre qual esta na tela
Pergunta perguntaNaTela() {
  return listaPerguntas.firstWhere(
    (p) => find.text(p.afirmacao).evaluate().isNotEmpty,
  );
}

String respostaErrada(Pergunta pergunta) {
  return opcoesQuiz.firstWhere((opcao) => opcao != pergunta.resposta);
}

// responde todas certas e chega no resultado, devolve a ordem que caiu
Future<List<String>> terminarQuiz(WidgetTester tester) async {
  final ordem = <String>[];
  for (var i = 0; i < listaPerguntas.length; i++) {
    final pergunta = perguntaNaTela();
    ordem.add(pergunta.afirmacao);

    await tester.ensureVisible(find.text(pergunta.resposta));
    await tester.pumpAndSettle();
    await tester.tap(find.text(pergunta.resposta));
    await tester.pump();

    // toda pergunta tem que mostrar a explicacao e a fonte
    expect(find.text(pergunta.explicacao), findsOneWidget);
    expect(find.text('Fonte: ${pergunta.fonte}'), findsOneWidget);

    await tocarProxima(tester);
  }
  return ordem;
}

void main() {
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
    await tester.pageBack();
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

  testWidgets('quiz aguenta fonte grande', (WidgetTester tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.ensureVisible(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mito ou verdade? Faça o quiz'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Depende'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Depende'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Próxima'));
    await tester.pumpAndSettle();
    expect(find.text('Próxima'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('todas as perguntas estao completas', () {
    for (final pergunta in listaPerguntas) {
      expect(opcoesQuiz, contains(pergunta.resposta));
      expect(pergunta.afirmacao, isNotEmpty);
      expect(pergunta.explicacao, isNotEmpty);
      expect(pergunta.fonte, isNotEmpty);
    }
    // o desafio pede as tres respostas
    for (final opcao in opcoesQuiz) {
      expect(listaPerguntas.where((p) => p.resposta == opcao), isNotEmpty);
    }
  });

  testWidgets('quiz abre na primeira pergunta', (WidgetTester tester) async {
    await abrirQuiz(tester);

    expect(find.text('Pergunta 1 de ${listaPerguntas.length}'), findsOneWidget);
    expect(find.text('Acertos: 0'), findsOneWidget);
    expect(find.text(perguntaNaTela().afirmacao), findsOneWidget);
    expect(find.text('Mito'), findsOneWidget);
    expect(find.text('Verdade'), findsOneWidget);
    expect(find.text('Depende'), findsOneWidget);
    expect(find.text('Próxima'), findsNothing);
  });

  testWidgets('resposta certa soma ponto', (WidgetTester tester) async {
    await abrirQuiz(tester);

    await tester.tap(find.text(perguntaNaTela().resposta));
    await tester.pump();

    expect(find.text('Acertos: 1'), findsOneWidget);
    expect(find.text('Acertou!'), findsOneWidget);
  });

  testWidgets('resposta errada mostra a certa', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final pergunta = perguntaNaTela();

    await tester.tap(find.text(respostaErrada(pergunta)));
    await tester.pump();

    expect(find.text('Acertos: 0'), findsOneWidget);
    expect(find.text('Errou! A resposta é ${pergunta.resposta}.'), findsOneWidget);
  });

  testWidgets('explicacao so aparece depois de responder', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final pergunta = perguntaNaTela();

    expect(find.text(pergunta.explicacao), findsNothing);
    expect(find.textContaining('Fonte:'), findsNothing);

    await tester.tap(find.text(respostaErrada(pergunta)));
    await tester.pump();

    expect(find.text(pergunta.explicacao), findsOneWidget);
    expect(find.text('Fonte: ${pergunta.fonte}'), findsOneWidget);
  });

  testWidgets('explicacao some na proxima pergunta', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final pergunta = perguntaNaTela();

    await tester.tap(find.text(pergunta.resposta));
    await tester.pump();
    await tocarProxima(tester);

    expect(find.text(pergunta.explicacao), findsNothing);
    expect(find.textContaining('Fonte:'), findsNothing);
  });

  testWidgets('nao da pra trocar a resposta', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final pergunta = perguntaNaTela();

    await tester.tap(find.text(respostaErrada(pergunta)));
    await tester.pump();
    await tester.tap(find.text(pergunta.resposta));
    await tester.pump();

    expect(find.text('Acertos: 0'), findsOneWidget);
    expect(find.text('Errou! A resposta é ${pergunta.resposta}.'), findsOneWidget);
  });

  testWidgets('proxima muda a pergunta', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final primeira = perguntaNaTela();

    await tester.tap(find.text(primeira.resposta));
    await tester.pump();
    await tocarProxima(tester);

    expect(find.text('Pergunta 2 de ${listaPerguntas.length}'), findsOneWidget);
    expect(find.text(primeira.afirmacao), findsNothing);
    expect(perguntaNaTela().afirmacao, isNot(primeira.afirmacao));
    expect(find.text('Acertos: 1'), findsOneWidget);
    expect(find.text('Próxima'), findsNothing);
  });

  testWidgets('barra de progresso anda quando responde', (WidgetTester tester) async {
    await abrirQuiz(tester);

    double progresso() {
      final barra = find.byType(LinearProgressIndicator);
      return tester.widget<LinearProgressIndicator>(barra).value!;
    }

    final total = listaPerguntas.length;
    expect(progresso(), 0);

    await tester.tap(find.text(perguntaNaTela().resposta));
    await tester.pump();
    expect(progresso(), 1 / total);

    // trocar de pergunta nao muda a barra, so responder
    await tocarProxima(tester);
    expect(progresso(), 1 / total);
  });

  testWidgets('quiz inteiro leva pro resultado', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final ordem = await terminarQuiz(tester);

    // cada pergunta aparece uma vez so, mesmo sorteando
    expect(ordem.toSet(), hasLength(listaPerguntas.length));

    final total = listaPerguntas.length;
    expect(find.text('Resultado'), findsOneWidget);
    expect(find.text('$total de $total'), findsOneWidget);
    expect(find.text('Você acertou 100%'), findsOneWidget);
    expect(find.text('Especialista em átomos!'), findsOneWidget);
  });

  testWidgets('voltar do resultado cai no explorar', (WidgetTester tester) async {
    await abrirQuiz(tester);
    await terminarQuiz(tester);

    await tester.tap(find.text('Voltar para Explorar'));
    await tester.pumpAndSettle();

    expect(find.text('Explorar'), findsOneWidget);
  });

  testWidgets('seta do resultado nao volta pro quiz', (WidgetTester tester) async {
    await abrirQuiz(tester);
    await terminarQuiz(tester);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Explorar'), findsOneWidget);
  });

  testWidgets('refazer comeca o quiz do zero', (WidgetTester tester) async {
    await abrirQuiz(tester);
    await terminarQuiz(tester);

    await tester.tap(find.text('Refazer o quiz'));
    await tester.pumpAndSettle();

    expect(find.text('Pergunta 1 de ${listaPerguntas.length}'), findsOneWidget);
    expect(find.text('Acertos: 0'), findsOneWidget);
  });

  testWidgets('refazer sorteia outra ordem', (WidgetTester tester) async {
    await abrirQuiz(tester);
    final primeira = await terminarQuiz(tester);

    await tester.tap(find.text('Refazer o quiz'));
    await tester.pumpAndSettle();
    final segunda = await terminarQuiz(tester);

    expect(segunda, isNot(equals(primeira)));
  });

  // abre so a tela de resultado com a nota que eu quiser
  Future<void> abrirResultado(WidgetTester tester, int acertos) async {
    telaDeCelular(tester);
    await tester.pumpWidget(
      MaterialApp(home: TelaResultado(acertos: acertos, total: 12)),
    );
  }

  testWidgets('mensagem muda com a nota', (WidgetTester tester) async {
    await abrirResultado(tester, 10);
    expect(find.text('Especialista em átomos!'), findsOneWidget);
    expect(find.text('Você acertou 83%'), findsOneWidget);

    await abrirResultado(tester, 6);
    expect(find.text('Mandou bem!'), findsOneWidget);

    await abrirResultado(tester, 5);
    expect(find.text('Cuidado com os mitos!'), findsOneWidget);

    await abrirResultado(tester, 0);
    expect(find.text('Cuidado com os mitos!'), findsOneWidget);
    expect(find.text('Você acertou 0%'), findsOneWidget);
  });

  testWidgets('resultado aguenta fonte grande', (WidgetTester tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await abrirResultado(tester, 7);

    expect(tester.takeException(), isNull);
  });
}
