import 'package:bytebank/dto/feature_dto.dart';
import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytebank/models/feature.dart';

final String urlBase = "$urlBaseApi/features";

const _featuresNaoEncontradas = 'Não foram encontradas as features';

class FeatureWebClient {
  Future<List<Feature>> todas() async {
    final resposta = await http.get('$urlBase/disponiveis');
    if (sucesso(resposta)) {
      final List jsonDecodificado = json.decode(resposta.body);
      return jsonDecodificado
          .map((json) => todasFeatures[FeatureDto.deJson(json).id])
          .where((feature) => feature != null)
          .toList();
    }
    throw Exception(_featuresNaoEncontradas);
  }
}
