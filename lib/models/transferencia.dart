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
}
