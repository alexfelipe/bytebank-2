import 'package:bytebank/webclient/webclient_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bytebank/models/feature.dart';

final String urlBase = "$urlBaseApi/features";

const _featuresNaoEncontradas = 'Não foram encontradas as features';

//TODO usei o http considerando a sugestão da documentação, tem outra lib recomendada?
class FeatureWebClient {

  Future<List<Feature>> todas() async {
    final resposta = await http.get(urlBase);
    //TODO essa abordagem de verificar o que a resposta indica é normal? Não teria algo como `isSuccessful`?
    if (resposta.statusCode == 200) {
      final List jsonDecodificado = json.decode(resposta.body);
      //TODO vi que tem diversas maneiras de serializar e deserializar json, qual delas recomenda? A que tem o gerador de código?
      return jsonDecodificado.map((json) => Feature.deJson(json)).toList();
    }
    throw Exception(_featuresNaoEncontradas);
  }

}
