import 'package:bytebank/dao/ContatoDao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioContatoState();
  }
}

class FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();
  final ContatoDao _dao = ContatoDao();

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
              controlador: _nomeController,
              rotulo: 'Nome',
              tipoTeclado: TextInputType.text,
            ),
            Editor(
              controlador: _numeroContaController,
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
                  onPressed: () {
                    final Contato contato = criaContato();
                    salva(contato);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void salva(Contato contato) async {
    final id = await _dao.insere(contato);
    Navigator.pop(context, id);
  }

  Contato criaContato() {
    final nome = _nomeController.text;
    final numeroConta = int.tryParse(_numeroContaController.text);
    return Contato(nome, numeroConta);
  }
}

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
