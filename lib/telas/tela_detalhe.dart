import 'package:flutter/material.dart';

class TelaDetalhe extends StatelessWidget {
  final Map<String, String> curiosidade;

  const TelaDetalhe({super.key, required this.curiosidade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              curiosidade['titulo']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              curiosidade['resumo']!,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const Divider(height: 32),
            Text(
              curiosidade['texto']!,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
