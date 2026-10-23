import 'package:flutter/material.dart';

import '../dados/curiosidades.dart';
import 'tela_detalhe.dart';
import 'tela_enviar_mito.dart';

class TelaCuriosidades extends StatelessWidget {
  const TelaCuriosidades({super.key});

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
      body: ListView.builder(
        // espaco pro botao nao tampar o ultimo item
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: listaCuriosidades.length,
        itemBuilder: (context, index) {
          final curiosidade = listaCuriosidades[index];
          return ListTile(
            leading: const Icon(Icons.article),
            title: Text(curiosidade.titulo),
            subtitle: Text(curiosidade.resumo),
            trailing: const Icon(Icons.chevron_right),
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
    );
  }
}
