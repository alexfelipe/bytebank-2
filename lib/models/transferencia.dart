import 'contato.dart';

class Transferencia {
  final double valor;
  final Contato contato;
  final DateTime data;

  Transferencia(
    this.valor,
    this.contato, {
    this.data,
  });

  @override
  String toString() {
    return 'Transferencia{valor: $valor, contato:  $contato, data: $data}';
  }

  Transferencia.deJson(Map<String, dynamic> json)
      : valor = json['valor'],
        contato = Contato.deJson(json['contato']),
        data = DateTime.parse(json['data']);

  Map<String, dynamic> paraJson() => {
        "valor": valor,
        "contato": contato.paraJson(),
      };
}
