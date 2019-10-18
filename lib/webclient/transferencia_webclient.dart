import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;

final String urlBase = '$urlBaseApi/transferencias';
const Map<String, String> baseHeaders = {
  "Content-type": "application/json",
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

  Future<TransacaoResposta> salva(Transferencia transferencia,
      String senha) async {
    Map<String, String> headers = _configuraSenhaNoHeader(senha);
    final Map<String, dynamic> json = transferencia.paraJson();
    final resposta = await http.post(
      urlBase,
      headers: headers,
      body: jsonEncode(json),
    );
    return validaResposta(resposta);
  }

  Future<TransacaoResposta> validaResposta(http.Response resposta) async {
    if (resposta.statusCode == 200 || resposta.statusCode == 409) {
      return TransacaoResposta(true);
    }
    if (resposta.statusCode == 400 || resposta.statusCode == 401) {
      return TransacaoResposta(
        false,
        mensagem: _mensagensDeFalha[resposta.statusCode],
      );
    }
    throw Exception("Não foi possível salvar transferência");
  }

  Map<String, String> _configuraSenhaNoHeader(String senha) {
    final Map<String, String> headers = Map<String, String>.from(baseHeaders);
    headers['senha'] = senha;
    return headers;
  }

  final Map<int, String> _mensagensDeFalha = {
    400: "Falha na requisição com a API",
    401: "Falha na autenticação"
  };
}

class TransacaoResposta {
  final String mensagem;
  final bool sucesso;

  TransacaoResposta(this.sucesso, {this.mensagem});
}
