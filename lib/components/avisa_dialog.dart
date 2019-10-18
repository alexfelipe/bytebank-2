import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvisaDialog extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String mensagem;

  const AvisaDialog({
    this.titulo,
    this.icone,
    this.mensagem,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titulo,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            child: Icon(
              icone,
              size: 80.0,
            ),
            visible: icone != null,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            mensagem,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
