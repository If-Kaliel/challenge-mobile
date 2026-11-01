class Pergunta {
  final String afirmacao;
  // 'Mito', 'Verdade' ou 'Depende'
  final String resposta;
  final String explicacao;
  final String fonte;

  const Pergunta({
    required this.afirmacao,
    required this.resposta,
    required this.explicacao,
    required this.fonte,
  });
}
