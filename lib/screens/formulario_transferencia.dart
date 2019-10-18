import 'package:bytebank/components/avisa_dialog.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/components/solicita_senha_dialog.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/transferencia_webclient.dart';
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
  final webClient = TransferenciaWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: Builder(
        builder: (context) => Padding(
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
      ),
    );
  }

  void _criaTransferencia(BuildContext context) async {
    final valor = double.tryParse(_controlador.text);
    final transferenciaCriada = Transferencia(valor, widget._contato);
    final String senha = await _solicitaSenha(context);
    if (senha != null) {
      _mostraProgresso(context);
      try {
        final TransacaoResposta resposta =
            await _salva(transferenciaCriada, senha);
        _mostraMensagemDeRetorno(resposta, context);
      } catch (e) {
        _mostraMensagem(
          'Falha ao transferir!',
          'Falha ao enviar a transferência para a API',
        );
      }
      Scaffold.of(context).hideCurrentSnackBar();
    }
  }

  Future _mostraMensagemDeRetorno(
      TransacaoResposta resposta, BuildContext context) async {
    if (resposta.sucesso) {
      await _mostraMensagem(
        'Transferência realizada!',
        'Transferência recebida com sucesso!',
        icone: Icons.done,
      );
      Navigator.of(context).pop();
    } else {
      _mostraMensagem(
        'Falha ao transferir!',
        resposta.mensagem,
        icone: Icons.error_outline,
      );
    }
  }

  Future<String> _solicitaSenha(
    BuildContext context,
  ) async =>
      showDialog(
        context: context,
        builder: (context) => SolicitaSenhaDialog(),
      );

  Future<TransacaoResposta> _salva(
    Transferencia transferencia,
    String senha,
  ) async {
    try {
      return webClient.salva(
        transferencia,
        senha,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> _mostraMensagem(
    String titulo,
    String mensagem, {
    IconData icone,
  }) =>
      showDialog(
          context: context,
          builder: (context) => AvisaDialog(
                titulo: titulo,
                mensagem: mensagem,
                icone: icone,
              ));

  void _mostraProgresso(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Wrap(children: <Widget>[
          Progresso(
            mensagem: "Enviando transfência",
          ),
        ]),
      ),
    );
  }
}
