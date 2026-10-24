import 'package:flutter/material.dart';

import '../tema.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o app'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Cores.amarelo,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.warning_amber, size: 48, color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Efeito Fallout',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'versão 1.0 - Sprint 1',
            textAlign: TextAlign.center,
            style: TextStyle(color: Cores.textoSuave),
          ),
          const SizedBox(height: 24),
          const _CardInfo(
            icone: Icons.info_outline,
            titulo: 'O que é o app',
            texto:
                'Um app de curiosidades sobre energia nuclear. Mostra os acidentes que marcaram a história, '
                'os avanços na medicina e na geração de energia, e ajuda a separar o que é mito do que é verdade.',
          ),
          const _CardInfo(
            icone: Icons.flag_outlined,
            titulo: 'Desafio 01 - Mitos e verdades',
            texto:
                'A tecnologia nuclear sofre com informações erradas e simplificações. '
                'O desafio é criar uma plataforma divertida e interativa onde o usuário avalia afirmações '
                'e entende se são verdadeiras, falsas ou se dependem do contexto.',
          ),
          const _CardInfo(
            icone: Icons.anchor,
            titulo: 'Empresa parceira: AMAZUL',
            texto:
                'A Amazônia Azul Tecnologias de Defesa S.A. é uma empresa pública criada em 2013, ligada ao '
                'Ministério da Defesa por meio da Marinha do Brasil. Ela desenvolve tecnologias para o Programa '
                'Nuclear Brasileiro, o Programa Nuclear da Marinha e o programa de submarinos (PROSUB).\n\n'
                '"Tecnologia Nacional em Benefício da Sociedade"',
          ),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.menu_book, color: Cores.amarelo),
                      SizedBox(width: 8),
                      Text(
                        'Fontes',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _Fonte(texto: 'AIEA - Agência Internacional de Energia Atômica'),
                  _Fonte(texto: 'CNEN - Comissão Nacional de Energia Nuclear'),
                  _Fonte(texto: 'AMAZUL - Kick-off do Challenge FIAP (out/2026)'),
                  _Fonte(texto: 'IPCC - emissões de CO2 por fonte de energia'),
                  _Fonte(texto: 'Imagens: Wikimedia Commons'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Feito por alunos da FIAP para o Challenge 2026',
            textAlign: TextAlign.center,
            style: TextStyle(color: Cores.textoSuave, fontSize: 12),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String texto;

  const _CardInfo({
    required this.icone,
    required this.titulo,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      // margem so embaixo pra ficar alinhado com o card de fontes
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, color: Cores.amarelo),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(texto, style: const TextStyle(height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class _Fonte extends StatelessWidget {
  final String texto;

  const _Fonte({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(color: Cores.amarelo)),
          Expanded(child: Text(texto)),
        ],
      ),
    );
  }
}
