import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:efeito_fallout/dados/categorias.dart';
import 'package:efeito_fallout/dados/curiosidades.dart';
import 'package:efeito_fallout/dados/perguntas.dart';
import 'package:efeito_fallout/main.dart';
import 'package:efeito_fallout/models/pergunta.dart';
import 'package:efeito_fallout/telas/tela_resultado.dart';
import 'package:efeito_fallout/tema.dart';

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

// preenche o formulario certinho, ainda sem enviar
Future<void> preencherMito(WidgetTester tester, String afirmacao) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Nome'),
    'Joao Silva',
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, 'E-mail'),
    'joao@email.com',
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, 'O que você ouviu?'),
    afirmacao,
  );
  await tester.ensureVisible(find.text('Categoria'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Categoria'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Energia').last);
  await tester.pumpAndSettle();
}

Future<void> enviarMito(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Enviar'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Enviar'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

// abre o app e vai ate a linha do tempo
Future<void> abrirLinhaDoTempo(WidgetTester tester) async {
  telaDeCelular(tester);
  await tester.pumpWidget(const EfeitoFalloutApp());
  await tester.tap(find.text('Começar'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Linha do tempo'));
  await tester.pumpAndSettle();
}

// liga a chave da tela inicial
Future<void> ligarLetrasMaiores(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Letras maiores'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Letras maiores'));
  await tester.pumpAndSettle();
}

// quanto o texto esta sendo aumentado na tela atual
double escalaDoTexto(WidgetTester tester, Finder texto) {
  return MediaQuery.textScalerOf(tester.element(texto)).scale(10) / 10;
}

void main() {
  testWidgets('mostra a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const EfeitoFalloutApp());

    expect(find.text('EFEITO FALLOUT'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget); // o simbolo de radiacao
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
    expect(find.textContaining('Foto: IAEA Imagebank, CC BY-SA 2.0.'), findsOneWidget);
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

  testWidgets('formulario certo entra na lista e limpa', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();

    expect(find.text('Mitos enviados (0)'), findsOneWidget);
    await preencherMito(tester, 'Quem mora perto de usina fica radioativo');

    await tester.ensureVisible(find.text('Enviar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enviar'));
    await tester.pumpAndSettle();

    expect(find.text('Enviado!'), findsOneWidget);
    expect(find.textContaining('Valeu, Joao!'), findsOneWidget);
    // nao pode prometer resposta por e-mail, isso nao existe
    expect(find.textContaining('por e-mail'), findsNothing);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Enviar um mito'), findsOneWidget);
    expect(find.text('Mitos enviados (1)'), findsOneWidget);
    expect(find.text('Quem mora perto de usina fica radioativo'), findsOneWidget);
    expect(find.text('Energia - Joao Silva'), findsOneWidget);

    final nome = find.widgetWithText(TextFormField, 'Nome');
    expect(tester.widget<TextFormField>(nome).controller!.text, isEmpty);
    // a categoria tambem tem que voltar a ficar vazia
    expect(find.text('Energia'), findsNothing);
  });

  testWidgets('switch esconde o nome na lista', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();

    await preencherMito(tester, 'Toda radiação faz mal pra saúde');
    await tester.ensureVisible(find.byType(Switch));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.pump();
    await enviarMito(tester);

    expect(find.text('Energia - Anônimo'), findsOneWidget);
  });

  testWidgets('da pra enviar dois mitos e remover', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();

    await preencherMito(tester, 'Primeiro mito que eu ouvi');
    await enviarMito(tester);
    await preencherMito(tester, 'Segundo mito que eu ouvi');
    await enviarMito(tester);
    expect(find.text('Mitos enviados (2)'), findsOneWidget);

    await tester.ensureVisible(find.byTooltip('Remover').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Remover').first);
    await tester.pump();
    expect(find.text('Mitos enviados (1)'), findsOneWidget);
    expect(find.text('Primeiro mito que eu ouvi'), findsOneWidget);
    expect(find.text('Segundo mito que eu ouvi'), findsNothing);
  });

  testWidgets('mitos continuam depois de sair da tela', (WidgetTester tester) async {
    await abrirLista(tester);
    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();

    await preencherMito(tester, 'Um mito qualquer de teste');
    await enviarMito(tester);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Enviar mito'));
    await tester.pumpAndSettle();
    expect(find.text('Mitos enviados (1)'), findsOneWidget);
  });

  test('todas as fotos existem e tem credito', () {
    for (final curiosidade in listaCuriosidades) {
      expect(File(curiosidade.imagem).existsSync(), isTrue, reason: curiosidade.imagem);
      expect(curiosidade.creditoFoto, isNotEmpty);
    }
    for (final categoria in listaCategorias) {
      expect(File(categoria.imagem).existsSync(), isTrue, reason: categoria.imagem);
      expect(categoria.creditoFoto, isNotEmpty);
    }
  });

  testWidgets('tela sobre mostra os creditos das fotos', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Sobre o app'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Créditos das fotos'), 300);
    await tester.scrollUntilVisible(
      find.text('Fukushima (2011): Digital Globe, CC BY-SA 3.0'),
      300,
    );
    expect(find.text('Fukushima (2011): Digital Globe, CC BY-SA 3.0'), findsOneWidget);
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
    // acertou tudo, nao tem o que revisar
    expect(find.textContaining('Para revisar'), findsNothing);
  });

  testWidgets('resultado mostra o que errou', (WidgetTester tester) async {
    await abrirQuiz(tester);

    final errada = perguntaNaTela();
    await tester.tap(find.text(respostaErrada(errada)));
    await tester.pump();
    await tocarProxima(tester);

    for (var i = 1; i < listaPerguntas.length; i++) {
      final pergunta = perguntaNaTela();
      await tester.ensureVisible(find.text(pergunta.resposta));
      await tester.pumpAndSettle();
      await tester.tap(find.text(pergunta.resposta));
      await tester.pump();
      await tocarProxima(tester);
    }

    await tester.ensureVisible(find.text('Para revisar (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Para revisar (1)'), findsOneWidget);
    expect(find.text(errada.afirmacao), findsOneWidget);
    expect(find.text('Resposta certa: ${errada.resposta}'), findsOneWidget);
    expect(find.text(errada.explicacao), findsOneWidget);
    expect(find.text('Fonte: ${errada.fonte}'), findsOneWidget);
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
      MaterialApp(
        home: TelaResultado(acertos: acertos, total: 12, erradas: const []),
      ),
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

  test('linha do tempo fica em ordem de ano', () {
    final anos = eventosDaLinhaDoTempo().map((e) => e.ano!).toList();

    expect(anos.first, 1895);
    expect(anos.last, 2026);
    for (var i = 1; i < anos.length; i++) {
      expect(anos[i], greaterThanOrEqualTo(anos[i - 1]));
    }
  });

  testWidgets('linha do tempo abre com todos os eventos', (WidgetTester tester) async {
    await abrirLinhaDoTempo(tester);
    final total = eventosDaLinhaDoTempo().length;

    expect(find.text('$total eventos, de 1895 a 2026'), findsOneWidget);
    expect(find.text('1895'), findsOneWidget);
    expect(find.text('O primeiro raio-X (1895)'), findsOneWidget);
  });

  testWidgets('filtro mostra so as tragedias', (WidgetTester tester) async {
    await abrirLinhaDoTempo(tester);

    await tester.tap(find.text('Tragédias'));
    await tester.pumpAndSettle();

    final tragedias = eventosDaLinhaDoTempo()
        .where((e) => e.categoria == 'Tragédias')
        .length;
    expect(find.text('$tragedias eventos, de 1945 a 2011'), findsOneWidget);
    expect(find.text('Hiroshima e Nagasaki (1945)'), findsOneWidget);
    expect(find.text('O primeiro raio-X (1895)'), findsNothing);
  });

  testWidgets('filtro mostra so os avancos e volta', (WidgetTester tester) async {
    await abrirLinhaDoTempo(tester);

    await tester.tap(find.text('Avanços'));
    await tester.pumpAndSettle();
    expect(find.text('O primeiro raio-X (1895)'), findsOneWidget);
    expect(find.text('Hiroshima e Nagasaki (1945)'), findsNothing);

    await tester.tap(find.text('Todos'));
    await tester.pumpAndSettle();
    expect(
      find.text('${eventosDaLinhaDoTempo().length} eventos, de 1895 a 2026'),
      findsOneWidget,
    );
  });

  testWidgets('tocar no evento abre os detalhes', (WidgetTester tester) async {
    await abrirLinhaDoTempo(tester);

    await tester.tap(find.text('O primeiro raio-X (1895)'));
    await tester.pumpAndSettle();

    expect(find.text('Detalhes'), findsOneWidget);
    expect(find.textContaining('Anna Bertha'), findsWidgets);
  });

  testWidgets('tragedias tem foto vermelha e fundo proprio', (WidgetTester tester) async {
    await abrirLista(tester);

    await tester.tap(find.text('Chernobyl (1986)'));
    await tester.pumpAndSettle();

    final tela = tester.widget<Scaffold>(find.byType(Scaffold).last);
    expect(tela.backgroundColor, Cores.fundoTragedia);
    expect(tester.widget<Image>(find.byType(Image)).color, Cores.filtroTragedia);
  });

  testWidgets('medicina nao tem o filtro vermelho', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Medicina'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Exame PET'));
    await tester.pumpAndSettle();

    final tela = tester.widget<Scaffold>(find.byType(Scaffold).last);
    expect(tela.backgroundColor, Cores.fundoEsperanca);
    expect(tester.widget<Image>(find.byType(Image)).color, isNull);
  });

  testWidgets('linha do tempo aguenta fonte grande', (WidgetTester tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await tester.ensureVisible(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Linha do tempo'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('letras maiores aumenta o texto', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());

    expect(escalaDoTexto(tester, find.text('EFEITO FALLOUT')), 1);

    await ligarLetrasMaiores(tester);
    expect(escalaDoTexto(tester, find.text('EFEITO FALLOUT')), closeTo(1.3, 0.01));
    final chave = tester.widget<SwitchListTile>(find.byType(SwitchListTile));
    expect(chave.value, isTrue);

    // desliga e volta ao normal
    await tester.tap(find.text('Letras maiores'));
    await tester.pumpAndSettle();
    expect(escalaDoTexto(tester, find.text('EFEITO FALLOUT')), 1);
  });

  testWidgets('letras maiores vale nas outras telas', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await ligarLetrasMaiores(tester);

    await tester.ensureVisible(find.text('Começar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(escalaDoTexto(tester, find.text('Escolha um tema')), closeTo(1.3, 0.01));
  });

  testWidgets('letras maiores nao diminui a fonte do celular', (WidgetTester tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await ligarLetrasMaiores(tester);

    expect(escalaDoTexto(tester, find.text('EFEITO FALLOUT')), 2);
  });

  testWidgets('letras maiores nao estoura nenhuma tela', (WidgetTester tester) async {
    telaDeCelular(tester);
    await tester.pumpWidget(const EfeitoFalloutApp());
    await ligarLetrasMaiores(tester);

    Future<void> abrir(String texto) async {
      await tester.ensureVisible(find.text(texto));
      await tester.pumpAndSettle();
      await tester.tap(find.text(texto));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: texto);
    }

    Future<void> voltar() async {
      await tester.pageBack();
      await tester.pumpAndSettle();
    }

    await abrir('Sobre o app');
    await voltar();
    await abrir('Começar');
    await abrir('Tragédias');
    await abrir('Chernobyl (1986)');
    await voltar();
    await abrir('Enviar mito');
    await voltar();
    await abrir('ver');
    await voltar();
    await voltar();
    await abrir('Linha do tempo');
    await voltar();
    await abrir('Mito ou verdade? Faça o quiz');
    await abrir(perguntaNaTela().resposta);
    await tester.ensureVisible(find.text('Próxima'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
