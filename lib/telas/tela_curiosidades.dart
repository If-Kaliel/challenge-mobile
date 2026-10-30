import 'package:flutter/material.dart';

import '../dados/categorias.dart';
import '../dados/curiosidades.dart';
import '../models/curiosidade.dart';
import '../tema.dart';
import 'tela_detalhe.dart';
import 'tela_enviar_mito.dart';
import 'tela_favoritos.dart';

class TelaCuriosidades extends StatefulWidget {
  // se vier null mostra todas
  final String? categoria;
  final List<Curiosidade> favoritos;

  const TelaCuriosidades({super.key, this.categoria, required this.favoritos});

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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: InkWell(
              onTap: _abrirFavoritos,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Cores.amarelo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Favoritos: ${favoritos.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Text('ver', style: TextStyle(color: Colors.black)),
                    const Icon(Icons.chevron_right, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // espaco pro botao nao tampar o ultimo item
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                final curiosidade = lista[index];
                final favorito = favoritos.contains(curiosidade);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    leading: Icon(
                      iconeDaCategoria(curiosidade.categoria),
                      color: Cores.amarelo,
                    ),
                    title: Text(
                      curiosidade.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(curiosidade.resumo),
                    trailing: IconButton(
                      icon: Icon(
                        favorito ? Icons.favorite : Icons.favorite_border,
                        color: favorito ? Cores.vermelho : null,
                      ),
                      onPressed: () => _favoritar(curiosidade),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaDetalhe(curiosidade: curiosidade),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
