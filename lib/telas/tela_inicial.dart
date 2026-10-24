import 'package:flutter/material.dart';

import '../tema.dart';
import 'tela_categorias.dart';
import 'tela_sobre.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Cores.amarelo,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Cores.amarelo.withValues(alpha: 0.4),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.warning_amber, size: 72, color: Colors.black),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'EFEITO FALLOUT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Curiosidades sobre energia nuclear: as tragédias, os avanços e o que é mito ou verdade.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Cores.textoSuave, height: 1.4),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaCategorias(),
                    ),
                  );
                },
                child: const Text('Começar'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaSobre()),
                  );
                },
                child: const Text('Sobre o app'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
