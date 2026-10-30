import 'package:flutter/material.dart';

import '../tema.dart';

// imagem da internet com loading e erro, pra nao repetir isso em toda tela
class ImagemRede extends StatelessWidget {
  final String url;
  final double? altura;
  // icone que aparece se a imagem nao carregar (sem internet por exemplo)
  final IconData iconeErro;

  const ImagemRede({
    super.key,
    required this.url,
    this.altura,
    this.iconeErro = Icons.image_not_supported,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: altura,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progresso) {
        if (progresso == null) return child;
        return Container(
          height: altura,
          color: Cores.superficie,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
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
