import 'dart:async';

import 'package:bytebank/screens/formulario_contato.dart';
import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:bytebank/screens/lista_contatos.dart';
import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/material.dart';

import 'models/contato.dart';
import 'screens/dashboard.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      onGenerateRoute: BytebankNavigator().todasRotas,
    );
  }
}

class BytebankNavigator {
  static const String _transferir = 'transferir';
  static const String _historico = 'historico';
  static const String _formContato = 'formContato';
  static const String _formTransferencia = 'formTransferencia';

  final Route<dynamic> Function(RouteSettings) todasRotas = (settings) {
    final Map<String, Route<dynamic>> rotas = {
      _transferir: MaterialPageRoute(builder: (context) => ListaContatos()),
      _historico:
          MaterialPageRoute(builder: (context) => ListaTransferencias()),
      _formContato:
          MaterialPageRoute(builder: (context) => FormularioContato()),
      _formTransferencia: MaterialPageRoute(builder: (context) {
        final Contato args = settings.arguments;
        return FormularioTransferencia(args);
      })
    };

    if (rotas.containsKey(settings.name)) {
      return rotas[settings.name];
    }
    return MaterialPageRoute(builder: (context) => Dashboard());
  };

  static Future<void> vaiParaTransferir(BuildContext context) =>
      Navigator.pushNamed(context, _transferir);

  static Future<void> vaiParaHistorico(BuildContext context) =>
      Navigator.pushNamed(context, _historico);

  static Future<int> vaiParaFormularioContatos(BuildContext context) =>
      Navigator.pushNamed(context, _formContato);

  static Future<void> vaiParaFormularioTransferencia(
          BuildContext context, Contato contato) =>
      Navigator.pushNamed(
        context,
        _formTransferencia,
        arguments: contato,
      );
}
