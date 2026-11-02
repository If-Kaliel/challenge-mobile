import 'package:flutter/material.dart';

import 'tema.dart';
import 'telas/tela_inicial.dart';

void main() {
  runApp(const EfeitoFalloutApp());
}

class EfeitoFalloutApp extends StatefulWidget {
  const EfeitoFalloutApp({super.key});

  @override
  State<EfeitoFalloutApp> createState() => _EfeitoFalloutAppState();
}

class _EfeitoFalloutAppState extends State<EfeitoFalloutApp> {
  // acessibilidade: aumenta o texto de todas as telas
  bool _letrasMaiores = false;

  void _mudarLetras(bool valor) {
    setState(() {
      _letrasMaiores = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Efeito Fallout',
      debugShowCheckedModeBanner: false,
      theme: criarTema(),
      builder: (context, child) {
        if (!_letrasMaiores) {
          return child!;
        }
        // pelo menos 30% maior. se a fonte do celular ja for maior, fica a do celular
        final escala = MediaQuery.textScalerOf(context);
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: escala.clamp(minScaleFactor: 1.3)),
          child: child!,
        );
      },
      home: TelaInicial(
        letrasMaiores: _letrasMaiores,
        aoMudarLetras: _mudarLetras,
      ),
    );
  }
}
