class TreinoModel {
  int? id;
  String titulo;
  String descricao;
  String repeticoes;
  String series;
  String peso;
  String diaSemana;
  String imagem;

  TreinoModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.repeticoes,
    required this.series,
    required this.peso,
    required this.diaSemana,
    required this.imagem,
  });

  // Converte um Treino para um Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'repeticoes': repeticoes,
      'series': series,
      'peso': peso,
      'diaSemana': diaSemana,
      'imagem': imagem,
    };
  }

  // Converte um Map em um Treino.
  factory TreinoModel.fromMap(Map<String, dynamic> map) {
    return TreinoModel(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      repeticoes: map['repeticoes'],
      series: map['series'],
      peso: map['peso'],
      diaSemana: map['diaSemana'],
      imagem: map['imagem'],
    );
  }
}
