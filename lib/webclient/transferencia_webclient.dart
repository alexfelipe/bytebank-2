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

  Future<TransacaoResposta> salva(
      Transferencia transferencia, String senha) async {
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
    if (_codigos.containsKey(resposta.statusCode)) {
      return _codigos[resposta.statusCode];
    }
    throw Exception("Não foi possível salvar transferência");
  }

  Map<String, String> _configuraSenhaNoHeader(String senha) {
    final Map<String, String> headers = Map<String, String>.from(baseHeaders);
    headers['senha'] = senha;
    return headers;
  }

  final Map<int, TransacaoResposta> _codigos = {
    400: TransacaoResposta.falhaRequisicao,
    401: TransacaoResposta.falhaAutenticacao,
    409: TransacaoResposta.duplicada,
    200: TransacaoResposta.sucesso,
    500: TransacaoResposta.erro,
  };
}

enum TransacaoResposta {
  sucesso,
  falhaAutenticacao,
  falhaRequisicao,
  duplicada,
  erro,
  desconhecido,
}
