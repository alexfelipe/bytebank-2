import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String urlBase = '$urlBaseApi/transferencias';
final Map<String, String> jsonContent = {"Content-type": "application/json"};

class TransferenciaWebClient {
  Future<List<Transferencia>> todas() async {
    final resposta = await http.get(urlBase);
    if (resposta.statusCode == 200) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado.map((i) => _paraTransferencia(i)).toList();
    }
    throw Exception('Falha ao buscar transferências');
  }

  Future<bool> salva(Transferencia transferencia) async {
    final Map<String, dynamic> body = _paraJson(transferencia);
    final resposta = await http.post(
      urlBase,
      headers: jsonContent,
      body: jsonEncode(body),
    );
    if (resposta.statusCode == 200) {
      return true;
    }
    return false;
  }

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
    return Contato(json['nome'], json['numeroConta']);
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
