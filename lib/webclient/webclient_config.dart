import 'package:http/http.dart' as http;

const String urlBaseApi = "https://7e01a136.ngrok.io";

bool sucesso(http.Response resposta) => resposta.statusCode == 200;