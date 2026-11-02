import 'package:flutter/material.dart';

import '../dados/categorias.dart';
import '../models/curiosidade.dart';
import '../tema.dart';
import '../widgets/imagem_local.dart';

class TelaDetalhe extends StatelessWidget {
  final Curiosidade curiosidade;

  const TelaDetalhe({super.key, required this.curiosidade});

  @override
  Widget build(BuildContext context) {
    final tragedia = curiosidade.categoria == 'Tragédias';
    final fundo = fundoDaCategoria(curiosidade.categoria);
    // preto nao aparece bem em cima do vermelho
    final corEtiqueta = tragedia ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: fundo,
      appBar: AppBar(backgroundColor: fundo, title: const Text('Detalhes')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagemLocal(
              caminho: curiosidade.imagem,
              altura: 260,
              iconeErro: iconeDaCategoria(curiosidade.categoria),
              sombria: tragedia,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Text(
                '${curiosidade.legenda} Foto: ${curiosidade.creditoFoto}.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Cores.textoSuave,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // etiqueta da categoria
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: corDaCategoria(curiosidade.categoria),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          iconeDaCategoria(curiosidade.categoria),
                          size: 16,
                          color: corEtiqueta,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          curiosidade.categoria,
                          style: TextStyle(
                            color: corEtiqueta,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    curiosidade.titulo,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    curiosidade.resumo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Cores.textoSuave,
                    ),
                  ),
                  const Divider(height: 32),
                  Text(
                    curiosidade.texto,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
