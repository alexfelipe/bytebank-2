class Contato {
  final int id;
  final String nome;
  final int numeroConta;

  Contato(this.nome, this.numeroConta, {this.id});

  @override
  String toString() {
    return 'Contato{id: $id, nome: $nome, numeroConta: $numeroConta}';
  }

}
