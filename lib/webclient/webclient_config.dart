import 'package:http/http.dart' as http;

const String urlBaseApi = "https://e7cfe166.ngrok.io";

bool sucesso(http.Response resposta) => resposta.statusCode == 200;