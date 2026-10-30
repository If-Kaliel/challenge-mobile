import 'package:flutter/material.dart';

import '../dados/categorias.dart';
import '../models/curiosidade.dart';
import '../servicos/leitor.dart';
import '../tema.dart';
import '../widgets/imagem_rede.dart';
import '../widgets/narrar_tela.dart';

class TelaDetalhe extends StatelessWidget {
  final Curiosidade curiosidade;

  const TelaDetalhe({super.key, required this.curiosidade});

  String get _textoParaOuvir =>
      '${curiosidade.titulo}. Foto: ${curiosidade.legenda} ${curiosidade.texto}';

  Future<void> _ouvir(BuildContext context) async {
    final deuCerto = await Leitor.falar(_textoParaOuvir);
    if (!deuCerto && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não deu pra ler em voz alta. Confere se o celular tem voz em português instalada',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NarrarTela(
      texto: _textoParaOuvir,
      child: Scaffold(
        appBar: AppBar(title: const Text('Detalhes')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagemRede(
                url: curiosidade.imagem,
                altura: 260,
                iconeErro: iconeDaCategoria(curiosidade.categoria),
              ),
              // pro TalkBack a legenda funciona como descricao da foto
              Semantics(
                label: 'Foto: ${curiosidade.legenda}',
                child: ExcludeSemantics(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                    child: Text(
                      '${curiosidade.legenda} (Foto: Wikimedia Commons)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Cores.textoSuave,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 150),
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
                        color: Cores.amarelo,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            iconeDaCategoria(curiosidade.categoria),
                            size: 16,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            curiosidade.categoria,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Semantics(
                      header: true,
                      child: Text(
                        curiosidade.titulo,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
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
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder<String?>(
                        valueListenable: Leitor.falandoAgora,
                        builder: (context, falando, child) {
                          final lendo = falando == _textoParaOuvir;
                          return OutlinedButton.icon(
                            onPressed: () {
                              if (lendo) {
                                Leitor.parar();
                              } else {
                                _ouvir(context);
                              }
                            },
                            icon: Icon(lendo ? Icons.stop : Icons.volume_up),
                            label: Text(lendo ? 'Parar' : 'Ouvir'),
                          );
                        },
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
      ),
    );
  }
}
