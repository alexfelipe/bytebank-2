import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;

final String urlBase = '$urlBaseApi/transferencias';
const Map<String, String> baseHeaders = {
  "Content-type": "application/json",
  //TODO vou criar o fluxo que exige a senha do usuário para criar transferência
  "senha": "1000",
};

const _transferenciasNaoEncontradas = 'Falha ao buscar transferências';

class TransferenciaWebClient {
  Future<List<Transferencia>> todas() async {
    final resposta = await http.get(urlBase);
    if (sucesso(resposta)) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado
          .map((json) => Transferencia.deJson(json))
          .toList();
    }
    throw Exception(_transferenciasNaoEncontradas);
  }

  Future<bool> salva(Transferencia transferencia) async {
    final Map<String, dynamic> json = transferencia.paraJson();
    final resposta = await http.post(
      urlBase,
      headers: baseHeaders,
      body: jsonEncode(json),
    );
    if (sucesso(resposta)) {
      return true;
    }
    return false;
  }
}
