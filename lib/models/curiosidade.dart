class Curiosidade {
  final String titulo;
  final String resumo;
  final String texto;
  final String categoria;
  final String imagem;
  // explica o que aparece na foto
  final String legenda;
  final String creditoFoto;
  // null = nao entra na linha do tempo
  final int? ano;
  // foto muito em pe, mostra inteira em vez de cortar
  final bool fotoInteira;

  const Curiosidade({
    required this.titulo,
    required this.resumo,
    required this.texto,
    required this.categoria,
    required this.imagem,
    required this.legenda,
    required this.creditoFoto,
    this.ano,
    this.fotoInteira = false,
  });
}
