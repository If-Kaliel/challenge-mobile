import 'package:flutter/material.dart';

import '../models/categoria.dart';
import '../tema.dart';

// fotos do wikimedia commons, guardadas em assets pra funcionar sem internet
const List<Categoria> listaCategorias = [
  Categoria(
    nome: 'Tragédias',
    icone: Icons.warning_amber,
    // mascaras de gas jogadas no chao de uma escola em Pripyat
    imagem: 'assets/imagens/fotos/tema_tragedias.jpg',
    creditoFoto: 'Adam Jones, CC BY-SA 2.0',
    cor: Cores.vermelho,
    corFundo: Cores.fundoTragedia,
    corCard: Cores.cardTragedia,
  ),
  Categoria(
    nome: 'Medicina',
    icone: Icons.local_hospital,
    // exame PET do cerebro
    imagem: 'assets/imagens/fotos/pet.jpg',
    creditoFoto: 'Jens Maus, domínio público',
    cor: Cores.verde,
    corFundo: Cores.fundoEsperanca,
    corCard: Cores.cardEsperanca,
  ),
  Categoria(
    nome: 'Energia',
    icone: Icons.bolt,
    // usina de Angra
    imagem: 'assets/imagens/fotos/tema_energia.jpg',
    creditoFoto: 'Rodrigo Soldon, CC BY 2.0',
    cor: Cores.amarelo,
    corFundo: Cores.fundo,
    corCard: Cores.superficie,
  ),
  Categoria(
    nome: 'Ciência',
    icone: Icons.science,
    imagem: 'assets/imagens/fotos/tema_ciencia.jpg',
    creditoFoto: 'Henri Manuel, domínio público',
    cor: Cores.azul,
    corFundo: Cores.fundo,
    corCard: Cores.superficie,
  ),
];

Categoria? categoriaPorNome(String nome) {
  for (final categoria in listaCategorias) {
    if (categoria.nome == nome) {
      return categoria;
    }
  }
  return null;
}

Color corDaCategoria(String nome) {
  return categoriaPorNome(nome)?.cor ?? Cores.amarelo;
}

Color fundoDaCategoria(String nome) {
  return categoriaPorNome(nome)?.corFundo ?? Cores.fundo;
}

Color cardDaCategoria(String nome) {
  return categoriaPorNome(nome)?.corCard ?? Cores.superficie;
}

// pega o icone pelo nome da categoria (usado na lista)
IconData iconeDaCategoria(String nome) {
  return categoriaPorNome(nome)?.icone ?? Icons.article;
}
