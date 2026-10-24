import 'package:flutter/material.dart';

import '../models/categoria.dart';

// imagens da wikimedia commons
const List<Categoria> listaCategorias = [
  Categoria(
    nome: 'Tragédias',
    icone: Icons.warning_amber,
    // escola abandonada em Pripyat, perto de Chernobyl
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7e/Pripyat_Abandoned_School.jpg/960px-Pripyat_Abandoned_School.jpg',
  ),
  Categoria(
    nome: 'Medicina',
    icone: Icons.local_hospital,
    // exame PET do cerebro
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c6/PET-image.jpg/960px-PET-image.jpg',
  ),
  Categoria(
    nome: 'Energia',
    icone: Icons.bolt,
    // usina de Angra
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d0/Angra1.jpg/960px-Angra1.jpg',
  ),
  Categoria(
    nome: 'Ciência',
    icone: Icons.science,
    imagem:
        'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7e/Marie_Curie_c1920.jpg/960px-Marie_Curie_c1920.jpg',
  ),
];
