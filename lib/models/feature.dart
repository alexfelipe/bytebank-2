import 'package:bytebank/webclient/webclient_config.dart';

final String urlBase = "$urlBaseApi/features";

class Feature {
  final String nome;
  final bool disponivel;

  Feature(this.nome, this.disponivel);

  @override
  String toString() {
    return 'Feature{nome: $nome, disponivel: $disponivel}';
  }
}