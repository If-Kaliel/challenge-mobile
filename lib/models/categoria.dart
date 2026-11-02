import 'package:flutter/material.dart';

class Categoria {
  final String nome;
  final IconData icone;
  final String imagem;
  final String creditoFoto;

  const Categoria({
    required this.nome,
    required this.icone,
    required this.imagem,
    required this.creditoFoto,
  });
}
