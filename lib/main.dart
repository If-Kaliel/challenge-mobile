import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'tema.dart';
import 'telas/tela_inicial.dart';
import 'widgets/botao_acessibilidade.dart';

// o botao de acessibilidade fica fora das telas, entao abre o painel por essa chave
final GlobalKey<NavigatorState> chaveNavegador = GlobalKey<NavigatorState>();

void main() {
  runApp(const EfeitoFalloutApp());
}

class EfeitoFalloutApp extends StatelessWidget {
  const EfeitoFalloutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Efeito Fallout',
      debugShowCheckedModeBanner: false,
      theme: criarTema(),
      // deixa o que vem do flutter em portugues, senao o TalkBack le "Back" na seta de voltar
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      navigatorKey: chaveNavegador,
      // coloca o botao de acessibilidade por cima de todas as telas
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            child!,
            BotaoAcessibilidade(chaveNavegador: chaveNavegador),
          ],
        );
      },
      home: const TelaInicial(),
    );
  }
}
