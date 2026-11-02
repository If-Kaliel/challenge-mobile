import 'package:flutter/material.dart';

import '../tema.dart';

// foto guardada dentro do app, assim funciona mesmo sem internet
class ImagemLocal extends StatelessWidget {
  final String caminho;
  final double? altura;
  // icone que aparece se a foto nao for encontrada
  final IconData iconeErro;
  // deixa a foto vermelha, usado nas tragedias
  final bool sombria;

  const ImagemLocal({
    super.key,
    required this.caminho,
    this.altura,
    this.iconeErro = Icons.image_not_supported,
    this.sombria = false,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      caminho,
      height: altura,
      width: double.infinity,
      fit: BoxFit.cover,
      color: sombria ? Cores.filtroTragedia : null,
      colorBlendMode: sombria ? BlendMode.color : null,
      errorBuilder: (context, erro, stackTrace) {
        return Container(
          height: altura,
          color: Cores.superficie,
          child: Center(
            child: Icon(iconeErro, size: 48, color: Cores.textoSuave),
          ),
        );
      },
    );
  }
}
