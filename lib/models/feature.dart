class Feature {
  final String nome;
  final bool disponivel;

  Feature(
    this.nome,
    this.disponivel,
  );

  @override
  String toString() {
    return 'Feature{nome: $nome, disponivel: $disponivel}';
  }
}
