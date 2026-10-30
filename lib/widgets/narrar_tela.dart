import 'package:flutter/material.dart';

import '../servicos/leitor.dart';

// le o texto quando a tela abre (se o modo de som estiver ligado) e para quando sai
class NarrarTela extends StatefulWidget {
  final String texto;
  final Widget child;

  const NarrarTela({super.key, required this.texto, required this.child});

  @override
  State<NarrarTela> createState() => _NarrarTelaState();
}

class _NarrarTelaState extends State<NarrarTela> {
  late final String _texto;

  @override
  void initState() {
    super.initState();
    _texto = widget.texto;
    Leitor.narrar(_texto);
  }

  @override
  void dispose() {
    Leitor.pararTexto(_texto);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
