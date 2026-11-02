import 'package:flutter/material.dart';

import '../dados/categorias.dart';
import '../dados/curiosidades.dart';
import '../models/curiosidade.dart';
import '../tema.dart';
import '../widgets/imagem_local.dart';
import 'tela_detalhe.dart';

class TelaLinhaDoTempo extends StatefulWidget {
  const TelaLinhaDoTempo({super.key});

  @override
  State<TelaLinhaDoTempo> createState() => _TelaLinhaDoTempoState();
}

class _TelaLinhaDoTempoState extends State<TelaLinhaDoTempo> {
  final List<String> filtros = ['Todos', 'Avanços', 'Tragédias'];
  String _filtro = 'Todos';

  bool _ehTragedia(Curiosidade curiosidade) {
    return curiosidade.categoria == 'Tragédias';
  }

  List<Curiosidade> get _eventos {
    final todos = eventosDaLinhaDoTempo();
    if (_filtro == 'Tragédias') {
      return todos.where(_ehTragedia).toList();
    }
    if (_filtro == 'Avanços') {
      return todos.where((c) => !_ehTragedia(c)).toList();
    }
    return todos;
  }

  Widget _botaoFiltro(String filtro) {
    return ChoiceChip(
      label: Text(filtro),
      selected: _filtro == filtro,
      selectedColor: Cores.amarelo,
      checkmarkColor: Colors.black,
      onSelected: (selecionado) {
        setState(() {
          _filtro = filtro;
        });
      },
    );
  }

  // a bolinha e a linha que ligam um evento no outro
  Widget _linha(Color cor) {
    return SizedBox(
      width: 24,
      child: Column(
        children: [
          Container(width: 2, height: 24, color: Cores.superficieClara),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
          ),
          Expanded(child: Container(width: 2, color: Cores.superficieClara)),
        ],
      ),
    );
  }

  Widget _cardEvento(Curiosidade evento) {
    return Card(
      color: cardDaCategoria(evento.categoria),
      margin: const EdgeInsets.symmetric(vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaDetalhe(curiosidade: evento),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 76,
              height: 96,
              child: ImagemLocal(
                caminho: evento.imagem,
                sombria: _ehTragedia(evento),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      evento.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      evento.resumo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Cores.textoSuave,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemDaLinha(Curiosidade evento) {
    final cor = corDaCategoria(evento.categoria);

    // IntrinsicHeight faz a linha acompanhar a altura do card
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 48,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '${evento.ano}',
                style: TextStyle(fontWeight: FontWeight.bold, color: cor),
              ),
            ),
          ),
          _linha(cor),
          Expanded(child: _cardEvento(evento)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventos = _eventos;

    return Scaffold(
      appBar: AppBar(title: const Text('Linha do tempo')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Wrap(
              spacing: 8,
              children: filtros.map(_botaoFiltro).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              '${eventos.length} eventos, de ${eventos.first.ano} a ${eventos.last.ano}',
              style: const TextStyle(color: Cores.textoSuave),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              itemCount: eventos.length,
              itemBuilder: (context, index) => _itemDaLinha(eventos[index]),
            ),
          ),
        ],
      ),
    );
  }
}
