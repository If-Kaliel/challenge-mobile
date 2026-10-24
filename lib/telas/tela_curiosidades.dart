import 'package:flutter/material.dart';

import '../dados/curiosidades.dart';
import '../models/curiosidade.dart';
import 'tela_detalhe.dart';
import 'tela_enviar_mito.dart';
import 'tela_favoritos.dart';

class TelaCuriosidades extends StatefulWidget {
  // se vier null mostra todas
  final String? categoria;
  final List<Curiosidade> favoritos;

  const TelaCuriosidades({
    super.key,
    this.categoria,
    required this.favoritos,
  });

  @override
  State<TelaCuriosidades> createState() => _TelaCuriosidadesState();
}

class _TelaCuriosidadesState extends State<TelaCuriosidades> {
  // a lista de favoritos agora vem da tela de categorias
  List<Curiosidade> get favoritos => widget.favoritos;

  List<Curiosidade> get lista {
    if (widget.categoria == null) {
      return listaCuriosidades;
    }
    return listaCuriosidades
        .where((c) => c.categoria == widget.categoria)
        .toList();
  }

  void _favoritar(Curiosidade curiosidade) {
    final jaEra = favoritos.contains(curiosidade);

    setState(() {
      if (jaEra) {
        favoritos.remove(curiosidade);
      } else {
        favoritos.add(curiosidade);
      }
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          jaEra ? 'Removido dos favoritos' : 'Adicionado aos favoritos',
        ),
      ),
    );
  }

  Future<void> _abrirFavoritos() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFavoritos(favoritos: favoritos),
      ),
    );
    // atualiza o contador e os coracoes quando volta (pode ter removido algum la)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria ?? 'Curiosidades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Meus favoritos',
            onPressed: _abrirFavoritos,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TelaEnviarMito()),
          );
        },
        icon: const Icon(Icons.add_comment),
        label: const Text('Enviar mito'),
      ),
      body: Column(
        children: [
          // contador que muda quando favorita
          InkWell(
            onTap: _abrirFavoritos,
            child: Container(
              width: double.infinity,
              color: Colors.amber.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    'Favoritos: ${favoritos.length}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Text('ver'),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // espaco pro botao nao tampar o ultimo item
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final curiosidade = lista[index];
                final favorito = favoritos.contains(curiosidade);

                return ListTile(
                  leading: const Icon(Icons.article),
                  title: Text(curiosidade.titulo),
                  subtitle: Text(curiosidade.resumo),
                  trailing: IconButton(
                    icon: Icon(
                      favorito ? Icons.favorite : Icons.favorite_border,
                      color: favorito ? Colors.red : null,
                    ),
                    onPressed: () => _favoritar(curiosidade),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhe(curiosidade: curiosidade),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
