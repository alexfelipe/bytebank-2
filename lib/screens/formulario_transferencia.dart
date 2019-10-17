import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/transferencia_webclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Nova transferência';

const _rotuloCampoValor = 'Valor';
const _tituloBotaoCriar = 'Transferir';

class FormularioTransferencia extends StatefulWidget {
  final Contato _contato;

  @override
  State<StatefulWidget> createState() {
    return _FormularioTransferenciaState();
  }

  FormularioTransferencia(this._contato);
}

class _FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                widget._contato.nome,
                style: TextStyle(fontSize: 24.0),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(widget._contato.numeroConta.toString(),
                    style: TextStyle(fontSize: 16.0)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: _controlador,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: _rotuloCampoValor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text(_tituloBotaoCriar),
                    onPressed: () {
                      final valor = double.tryParse(_controlador.text);
                      final transferenciaCriada =
                          Transferencia(valor, widget._contato);
                      _salva(transferenciaCriada);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _salva(Transferencia transferencia) async {
    //TODO tanto client como o DAO eu pensei como uma dependência que poderia ser entregue via injeção, se tiverem exemplo, pode avisar
    final bool salvo = await TransferenciaWebClient().salva(transferencia);
    if (salvo) {
      Navigator.pop(context);
    }
  }
}
