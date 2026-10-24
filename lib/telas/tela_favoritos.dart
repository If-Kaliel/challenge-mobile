import 'package:flutter/material.dart';

import '../models/curiosidade.dart';
import '../tema.dart';
import 'tela_detalhe.dart';

class TelaFavoritos extends StatefulWidget {
  // recebe a mesma lista da tela de curiosidades, ai se remover aqui remove la tambem
  final List<Curiosidade> favoritos;

  const TelaFavoritos({super.key, required this.favoritos});

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  void _remover(Curiosidade curiosidade) {
    setState(() {
      widget.favoritos.remove(curiosidade);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text('${curiosidade.titulo} saiu dos favoritos'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus favoritos'),
      ),
      body: widget.favoritos.isEmpty ? _listaVazia() : _lista(),
    );
  }

  Widget _listaVazia() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Cores.textoSuave),
            SizedBox(height: 16),
            Text(
              'Você ainda não favoritou nada',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Toque no coração das curiosidades pra salvar aqui.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Cores.textoSuave),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lista() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.favoritos.length,
      itemBuilder: (context, index) {
        final curiosidade = widget.favoritos[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.favorite, color: Cores.vermelho),
            title: Text(curiosidade.titulo),
            subtitle: Text(
              curiosidade.resumo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _remover(curiosidade),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaDetalhe(curiosidade: curiosidade),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
