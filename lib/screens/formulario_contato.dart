import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioContatoState();
  }
}

class FormularioContatoState extends State<FormularioContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo contato'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              rotulo: 'Nome',
              tipoTeclado: TextInputType.text,
            ),
            Editor(
              rotulo: 'Número da conta',
              tipoTeclado: TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Criar'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Editor extends StatelessWidget {
  final String rotulo;
  final TextInputType tipoTeclado;

  const Editor({
    this.tipoTeclado,
    this.rotulo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
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