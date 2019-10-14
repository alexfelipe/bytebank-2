class Contato {
  final int id;
  final String nome;
  final int numeroConta;

  Contato(
    this.nome,
    this.numeroConta, {
    this.id,
  });

  @override
  String toString() {
    return 'Contato{id: $id, nome: $nome, numeroConta: $numeroConta}';
  }

  Contato.deJson(Map<String, dynamic> json)
      : nome = json['nome'],
        numeroConta = json['numeroConta'],
        id = json['id'];

  Map<String, dynamic> paraJson() => {
    "nome" : nome,
    "numeroConta" : numeroConta
  };
}
