import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SolicitaSenhaDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SolicitaSenhaDialogState();
  }
}

class _SolicitaSenhaDialogState extends State<SolicitaSenhaDialog> {
  final TextEditingController _controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Digite a senha'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            textAlign: TextAlign.center,
            maxLength: 4,
            keyboardType: TextInputType.number,
            style: TextStyle(
              letterSpacing: 24.0,
              fontSize: 28.0,
            ),
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: _controlador,
          ),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () => Navigator.pop(context, _controlador.text),
          ),
        ],
      ),
    );
  }
}
