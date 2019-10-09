import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String urlBase = 'http://374ba673.ngrok.io/transferencias';

class TransferenciaWebClient {
  Future<List<Transferencia>> todas() async {
    final resposta = await http.get(urlBase);
    print(resposta);
    if (resposta.statusCode == 200) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado.map((i) => converte(i)).toList();
    }
    throw Exception('Falha ao buscar transferências');
  }

  Transferencia converte(Map<String, dynamic> mapa) {
    return Transferencia(
      mapa['valor'],
      Contato(
        mapa['contato']['nome'],
        mapa['contato']['numeroConta'],
      ),
    );
  }

  Future<bool> salva(Transferencia transferencia) async {
    final Map<String, dynamic> body = converteParaJson(transferencia);
    print('body to post $body');
    final resposta = await http.post(
      urlBase,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(body),
    );
    print('resposta marota ${resposta.statusCode}');
    if (resposta.statusCode == 200) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> converteParaJson(Transferencia transferencia) {
    return {
      "valor": transferencia.valor,
      "contato": {
        "nome": transferencia.contato.nome,
        "numeroConta": transferencia.contato.numeroConta
      }
    };
  }
}
