import 'package:flutter/material.dart';

import 'telas/tela_inicial.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const TelaInicial(),
    );
  }
}
