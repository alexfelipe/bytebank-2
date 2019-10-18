import 'package:http/http.dart' as http;

const String urlBaseApi = "https://000c45f4.ngrok.io";

bool sucesso(http.Response resposta) => resposta.statusCode == 200;