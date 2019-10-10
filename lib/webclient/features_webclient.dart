import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytebank/models/feature.dart';

final String urlBase = "$urlBaseApi/features";

const _featuresNaoEncontradas = 'Não foram encontradas as features';

class FeatureWebClient {
  Future<List<Feature>> todas() async {
    final resposta = await http.get(urlBase);
    if (resposta.statusCode == 200) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado.map((json) => _converteParaFeature(json)).toList();
    }
    throw Exception(_featuresNaoEncontradas);
  }

  Feature _converteParaFeature(Map<String, dynamic> json) {
    return Feature(
      json['nome'],
      json['disponivel'],
    );
  }
}
