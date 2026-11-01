import 'package:flutter/material.dart';

import '../dados/perguntas.dart';
import '../models/pergunta.dart';
import '../tema.dart';
import 'tela_resultado.dart';

class TelaQuiz extends StatefulWidget {
  const TelaQuiz({super.key});

  @override
  State<TelaQuiz> createState() => _TelaQuizState();
}

class _TelaQuizState extends State<TelaQuiz> {
  int _perguntaAtual = 0;
  int _acertos = 0;
  // null = ainda nao respondeu essa pergunta
  String? _respostaEscolhida;

  Pergunta get _pergunta => listaPerguntas[_perguntaAtual];
  bool get _respondeu => _respostaEscolhida != null;
  bool get _acertou => _respostaEscolhida == _pergunta.resposta;

  void _responder(String resposta) {
    // nao deixa trocar depois de responder
    if (_respondeu) {
      return;
    }

    setState(() {
      _respostaEscolhida = resposta;
      if (resposta == _pergunta.resposta) {
        _acertos++;
      }
    });
  }

  void _proxima() {
    if (_perguntaAtual == listaPerguntas.length - 1) {
      _mostrarResultado();
      return;
    }

    setState(() {
      _perguntaAtual++;
      _respostaEscolhida = null;
    });
  }

  void _mostrarResultado() {
    // troca a tela pra o voltar do resultado nao cair no quiz ja terminado
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaResultado(acertos: _acertos, total: listaPerguntas.length),
      ),
    );
  }

  // antes de responder fica amarelo, depois mostra o certo e o errado
  Color? _corDoBotao(String opcao) {
    if (!_respondeu) {
      return null;
    }
    if (opcao == _pergunta.resposta) {
      return Cores.verde;
    }
    if (opcao == _respostaEscolhida) {
      return Cores.vermelho;
    }
    return Cores.superficieClara;
  }

  Widget _botaoOpcao(String opcao) {
    final corretaMarcada = _respondeu && opcao == _pergunta.resposta;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _corDoBotao(opcao),
          foregroundColor: _respondeu && !corretaMarcada ? Cores.texto : null,
        ),
        onPressed: () => _responder(opcao),
        child: Text(opcao),
      ),
    );
  }

  // o desafio da AMAZUL pede explicacao e referencia depois de cada resposta
  Widget _cardExplicacao() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _pergunta.explicacao,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.menu_book, size: 16, color: Cores.textoSuave),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Fonte: ${_pergunta.fonte}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Cores.textoSuave,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mito ou verdade?')),
      // a tela inteira rola, assim nao estoura com a fonte do celular grande
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pergunta ${_perguntaAtual + 1} de ${listaPerguntas.length}',
                    style: const TextStyle(color: Cores.textoSuave),
                  ),
                ),
                Text(
                  'Acertos: $_acertos',
                  style: const TextStyle(
                    color: Cores.amarelo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Text(
                  _pergunta.afirmacao,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            for (final opcao in opcoesQuiz) _botaoOpcao(opcao),
            if (_respondeu) ...[
              const SizedBox(height: 4),
              Text(
                _acertou
                    ? 'Acertou!'
                    : 'Errou! A resposta é ${_pergunta.resposta}.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _acertou ? Cores.verde : Cores.vermelho,
                ),
              ),
              const SizedBox(height: 8),
              _cardExplicacao(),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: _proxima, child: const Text('Próxima')),
            ],
          ],
        ),
      ),
    );
  }
}
