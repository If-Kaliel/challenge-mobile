import 'package:flutter/material.dart';

import '../dados/curiosidades.dart';
import '../models/curiosidade.dart';
import 'tela_detalhe.dart';
import 'tela_enviar_mito.dart';

class TelaCuriosidades extends StatefulWidget {
  const TelaCuriosidades({super.key});

  @override
  State<TelaCuriosidades> createState() => _TelaCuriosidadesState();
}

class _TelaCuriosidadesState extends State<TelaCuriosidades> {
  final List<Curiosidade> favoritos = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curiosidades'),
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
          Container(
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              // espaco pro botao nao tampar o ultimo item
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: listaCuriosidades.length,
              itemBuilder: (context, index) {
                final curiosidade = listaCuriosidades[index];
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
