import 'package:flutter/material.dart';

import '../tema.dart';
import 'tela_quiz.dart';

class TelaResultado extends StatelessWidget {
  final int acertos;
  final int total;

  const TelaResultado({super.key, required this.acertos, required this.total});

  int get _porcentagem => (acertos / total * 100).round();

  String get _titulo {
    if (_porcentagem >= 80) {
      return 'Especialista em átomos!';
    }
    if (_porcentagem >= 50) {
      return 'Mandou bem!';
    }
    return 'Cuidado com os mitos!';
  }

  String get _mensagem {
    if (_porcentagem >= 80) {
      return 'Você sabe separar mito de verdade sobre a energia nuclear.';
    }
    if (_porcentagem >= 50) {
      return 'Você já sabe bastante, mas ainda caiu em alguns mitos. Que tal tentar de novo?';
    }
    return 'Tem muita informação errada por aí. Explore as curiosidades e tente de novo.';
  }

  Color get _cor {
    if (_porcentagem >= 80) {
      return Cores.verde;
    }
    if (_porcentagem >= 50) {
      return Cores.amarelo;
    }
    return Cores.vermelho;
  }

  IconData get _icone {
    if (_porcentagem >= 80) {
      return Icons.emoji_events;
    }
    if (_porcentagem >= 50) {
      return Icons.thumb_up;
    }
    return Icons.warning_amber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _cor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_icone, size: 64, color: Colors.black),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$acertos de $total',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: _cor,
                ),
              ),
              Text(
                'Você acertou $_porcentagem%',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Cores.textoSuave),
              ),
              const SizedBox(height: 16),
              Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  // troca a tela pra nao voltar pro resultado antigo
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaQuiz()),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refazer o quiz'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.explore),
                label: const Text('Voltar para Explorar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
