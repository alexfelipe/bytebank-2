import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final String rotulo;
  final TextInputType tipoTeclado;
  final TextEditingController controlador;

  const Editor({
    this.tipoTeclado,
    this.rotulo,
    this.controlador,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: rotulo,
        ),
      ),
    );
  }
}
