import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/transferencia_webclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  final Contato _contato;

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }

  FormularioTransferencia(this._contato);
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova transferência'),
      ),
      body: Column(
        children: <Widget>[
          Text(widget._contato.nome),
          Text(widget._contato.numeroConta.toString()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controlador,
              decoration: InputDecoration(labelText: 'Valor'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                child: Text('Criar'),
                onPressed: () {
                  final valor = double.tryParse(_controlador.text);
                  final transferenciaCriada = Transferencia(valor, widget._contato);
                  salva(transferenciaCriada);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void salva(Transferencia transferencia) async {
    final bool salvo = await TransferenciaWebClient().salva(transferencia);
    if(salvo) {
      Navigator.pop(context);
    }
  }
}
