import 'package:flutter/material.dart';

import '../servicos/leitor.dart';
import '../tema.dart';

// botao azul de maozinhas no canto da tela, no estilo do que aparece nos sites do governo.
// fica um pouco mais pra baixo que la pra nao tampar os coracoes das listas
class BotaoAcessibilidade extends StatefulWidget {
  final GlobalKey<NavigatorState> chaveNavegador;

  const BotaoAcessibilidade({super.key, required this.chaveNavegador});

  @override
  State<BotaoAcessibilidade> createState() => _BotaoAcessibilidadeState();
}

class _BotaoAcessibilidadeState extends State<BotaoAcessibilidade> {
  bool _painelAberto = false;

  Future<void> _abrirPainel() async {
    final contexto = widget.chaveNavegador.currentContext;
    if (contexto == null || _painelAberto) {
      return;
    }

    _painelAberto = true;
    await showDialog(
      context: contexto,
      builder: (context) => const _PainelAcessibilidade(),
    );
    _painelAberto = false;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8,
      // logo acima do botao enviar mito
      bottom: MediaQuery.paddingOf(context).bottom + 88,
      // container: true faz o botao ser um item separado pro TalkBack,
      // sem isso o rotulo ia pra tela inteira
      child: Semantics(
        container: true,
        button: true,
        label: 'Acessibilidade',
        hint: 'Abre as opções de acessibilidade',
        child: Material(
          color: Cores.azul,
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          child: InkWell(
            onTap: _abrirPainel,
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.sign_language, color: Colors.white, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}

class _PainelAcessibilidade extends StatelessWidget {
  const _PainelAcessibilidade();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Acessibilidade'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: Leitor.modoSom,
              builder: (context, ligado, child) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: Icon(ligado ? Icons.volume_up : Icons.volume_off),
                  title: const Text('Modo de som'),
                  subtitle: const Text('Lê as telas em voz alta'),
                  value: ligado,
                  onChanged: (valor) => Leitor.alternarModoSom(),
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Para navegar sem enxergar, ligue o TalkBack nas configurações do celular. O app funciona com ele.',
              style: TextStyle(color: Cores.textoSuave),
            ),
            const SizedBox(height: 8),
            const Text(
              'A tradução para Libras ainda não está disponível no app.',
              style: TextStyle(color: Cores.textoSuave),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
