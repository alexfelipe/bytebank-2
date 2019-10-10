import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytebank/models/feature.dart';

class FeatureWebClient {
  Future<List<Feature>> todas() async {
    final resposta = await http.get(urlBase);
    if (resposta.statusCode == 200) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado.map((mapa) => converteParaFeature(mapa)).toList();
    }
    throw Exception('Não foram encontradas as features');
  }

  Feature converteParaFeature(Map<String, dynamic> json) {
    return Feature(
      json['nome'],
      json['disponivel'],
    );
  }
}
