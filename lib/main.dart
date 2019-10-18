import 'package:bytebank/screens/lista_contatos.dart';
import 'package:flutter/material.dart';
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
      home: BytebankNavegador.destinoInicial,
    );
  }
}

class BytebankNavegador {

  static final Widget destinoInicial = Dashboard();

  Future<void> vaiParaInicio(context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );

  Future<void> vaiParaListaContatos(context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListaContatos(),
        ),
      );
}
