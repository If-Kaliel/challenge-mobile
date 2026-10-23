import 'package:flutter/material.dart';

class TelaCuriosidades extends StatelessWidget {
  const TelaCuriosidades({super.key});

  // dados de teste por enquanto
  final List<Map<String, String>> curiosidades = const [
    {
      'titulo': 'Chernobyl (1986)',
      'resumo':
          'O pior acidente nuclear da história aconteceu na Ucrânia, em 26 de abril de 1986, quando o reator 4 explodiu.',
    },
    {
      'titulo': 'Césio-137 em Goiânia (1987)',
      'resumo':
          'Catadores abriram um aparelho de radioterapia abandonado e o pó brilhante contaminou centenas de pessoas.',
    },
    {
      'titulo': 'Hiroshima e Nagasaki (1945)',
      'resumo':
          'As duas únicas bombas atômicas usadas em guerra foram lançadas sobre o Japão em agosto de 1945.',
    },
    {
      'titulo': 'Fukushima (2011)',
      'resumo':
          'Um terremoto seguido de tsunami desligou o resfriamento da usina e três reatores derreteram.',
    },
    {
      'titulo': 'O primeiro raio-X (1895)',
      'resumo':
          'Wilhelm Röntgen fez a primeira radiografia da história: a mão da esposa dele, com anel e tudo.',
    },
    {
      'titulo': 'Exame PET',
      'resumo':
          'Uma pequena quantidade de material radioativo ajuda os médicos a encontrar tumores no corpo.',
    },
    {
      'titulo': 'Angra 1 e Angra 2',
      'resumo':
          'O Brasil tem duas usinas nucleares funcionando em Angra dos Reis, no Rio de Janeiro.',
    },
    {
      'titulo': 'Banana radioativa?',
      'resumo':
          'A banana tem potássio-40, que é levemente radioativo. Mas teria que comer milhões de uma vez pra fazer mal.',
    },
    {
      'titulo': 'Marie Curie',
      'resumo':
          'Ganhou dois prêmios Nobel, um de Física e outro de Química, estudando a radioatividade.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curiosidades'),
      ),
      body: ListView.builder(
        itemCount: curiosidades.length,
        itemBuilder: (context, index) {
          final item = curiosidades[index];
          return ListTile(
            leading: const Icon(Icons.article),
            title: Text(item['titulo']!),
            subtitle: Text(item['resumo']!),
          );
        },
      ),
    );
  }
}
