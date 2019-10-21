import 'package:http/http.dart' as http;

const String urlBaseApi = "https://79eb642a.ngrok.io";

bool sucesso(http.Response resposta) => resposta.statusCode == 200;