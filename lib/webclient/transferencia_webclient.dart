import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String urlBase = '$urlBaseApi/transferencias';
const Map<String, String> applicationJson = {"Content-type": "application/json"};

const _transferenciasNaoEncontradas = 'Falha ao buscar transferências';

class TransferenciaWebClient {

  Future<List<Transferencia>> todas() async {
    final resposta = await http.get(urlBase);
    if (resposta.statusCode == 200) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado.map((json) => _paraTransferencia(json)).toList();
    }
    throw Exception(_transferenciasNaoEncontradas);
  }

  Future<bool> salva(Transferencia transferencia) async {
    final Map<String, dynamic> json = _paraJson(transferencia);
    final resposta = await http.post(
      urlBase,
      headers: applicationJson,
      body: jsonEncode(json),
    );
    if (resposta.statusCode == 200) {
      return true;
    }
    return false;
  }

  //TODO usando as diferentes formas para ver como funciona e entender os problemas
  Transferencia _paraTransferencia(Map<String, dynamic> json) {
    return Transferencia(
      json['valor'],
      _paraContato(
        json['contato'],
      ),
      data: DateTime.parse(json['data']),
    );
  }

  Contato _paraContato(Map<String, dynamic> json) {
    return Contato(
      json['nome'],
      json['numeroConta'],
    );
  }

  Map<String, dynamic> _paraJson(Transferencia transferencia) {
    return {
      "valor": transferencia.valor,
      "contato": {
        "nome": transferencia.contato.nome,
        "numeroConta": transferencia.contato.numeroConta
      }
    };
  }
}
