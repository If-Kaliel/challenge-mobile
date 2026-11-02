import 'package:flutter/material.dart';

import '../models/categoria.dart';

// fotos do wikimedia commons, guardadas em assets pra funcionar sem internet
const List<Categoria> listaCategorias = [
  Categoria(
    nome: 'Tragédias',
    icone: Icons.warning_amber,
    // escola abandonada em Pripyat, perto de Chernobyl
    imagem: 'assets/imagens/fotos/tema_tragedias.jpg',
    creditoFoto: 'Shanomag, CC BY-SA 4.0',
  ),
  Categoria(
    nome: 'Medicina',
    icone: Icons.local_hospital,
    // exame PET do cerebro
    imagem: 'assets/imagens/fotos/pet.jpg',
    creditoFoto: 'Jens Maus, domínio público',
  ),
  Categoria(
    nome: 'Energia',
    icone: Icons.bolt,
    // usina de Angra
    imagem: 'assets/imagens/fotos/tema_energia.jpg',
    creditoFoto: 'Rodrigo Soldon, CC BY 2.0',
  ),
  Categoria(
    nome: 'Ciência',
    icone: Icons.science,
    imagem: 'assets/imagens/fotos/tema_ciencia.jpg',
    creditoFoto: 'Henri Manuel, domínio público',
  ),
];

// pega o icone pelo nome da categoria (usado na lista)
IconData iconeDaCategoria(String nome) {
  for (final categoria in listaCategorias) {
    if (categoria.nome == nome) {
      return categoria.icone;
    }
  }
  return Icons.article;
}
