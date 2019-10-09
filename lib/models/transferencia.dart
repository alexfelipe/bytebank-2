import 'contato.dart';

class Transferencia {
  final double valor;
  final Contato contato;

  Transferencia(this.valor, this.contato);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, contato:  $contato}';
  }
}
