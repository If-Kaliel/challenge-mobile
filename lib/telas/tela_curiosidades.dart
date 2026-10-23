import 'package:flutter/material.dart';

import '../dados/curiosidades.dart';
import 'tela_detalhe.dart';

class TelaCuriosidades extends StatelessWidget {
  const TelaCuriosidades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curiosidades'),
      ),
      body: ListView.builder(
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
