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
                      _criaTransferencia(context);
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

  void _criaTransferencia(BuildContext context) async {
    final valor = double.tryParse(_controlador.text);
    final transferenciaCriada = Transferencia(valor, widget._contato);

    TextEditingController controller = TextEditingController();

    final String senha = await _solicitaSenha(context, controller);
    _salva(transferenciaCriada, senha);
  }

  Future<String> _solicitaSenha(
    BuildContext context,
    TextEditingController controlador,
  ) async =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                controller: controlador,
              ),
              RaisedButton(
                child: Text('Confirmar'),
                onPressed: () => Navigator.pop(context, controlador.text),
              ),
            ],
          ),
        ),
      );

  void _salva(Transferencia transferencia, String senha) async {
    final TransacaoResposta resposta = await TransferenciaWebClient().salva(
      transferencia,
      senha,
    );
    if (resposta.sucesso) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Transação não realizada'),
          content: Text(resposta.mensagem),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fechar'),
            )
          ],
        ),
      );
    }
  }
}
