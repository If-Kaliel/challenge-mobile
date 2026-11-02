import 'package:flutter/material.dart';

class Categoria {
  final String nome;
  final IconData icone;
  final String imagem;
  final String creditoFoto;
  final Color cor;
  // fundo das telas dessa categoria
  final Color corFundo;
  final Color corCard;

  const Categoria({
    required this.nome,
    required this.icone,
    required this.imagem,
    required this.creditoFoto,
    required this.cor,
    required this.corFundo,
    required this.corCard,
  });
}
