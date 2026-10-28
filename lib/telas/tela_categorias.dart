import 'package:flutter/material.dart';

import '../dados/categorias.dart';
import '../models/categoria.dart';
import '../models/curiosidade.dart';
import '../tema.dart';
import '../widgets/imagem_rede.dart';
import 'tela_curiosidades.dart';
import 'tela_favoritos.dart';

class TelaCategorias extends StatefulWidget {
  const TelaCategorias({super.key});

  @override
  State<TelaCategorias> createState() => _TelaCategoriasState();
}

class _TelaCategoriasState extends State<TelaCategorias> {
  // os favoritos ficam aqui pra nao sumirem quando troca de categoria
  final List<Curiosidade> favoritos = [];

  // categoria null = mostra todas
  Future<void> _abrirCuriosidades(String? categoria) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaCuriosidades(
          categoria: categoria,
          favoritos: favoritos,
        ),
      ),
    );
    setState(() {});
  }

  Future<void> _abrirFavoritos() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFavoritos(favoritos: favoritos),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Meus favoritos',
            onPressed: _abrirFavoritos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Escolha um tema',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: listaCategorias.length,
                itemBuilder: (context, index) {
                  return _cardCategoria(listaCategorias[index]);
                },
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _abrirCuriosidades(null),
              icon: const Icon(Icons.list),
              label: const Text('Ver todas as curiosidades'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardCategoria(Categoria categoria) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _abrirCuriosidades(categoria.nome),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ImagemRede(url: categoria.imagem, iconeErro: categoria.icone),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(categoria.icone, color: Cores.amarelo),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      categoria.nome,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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
