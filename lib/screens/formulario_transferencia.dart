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
    final double valor = double.tryParse(_controlador.text);
    final Transferencia transferenciaCriada =
        Transferencia(valor, widget._contato);
    final String senha = await _solicitaSenha(context);
    if (senha != null) {
      _mostraProgresso(context);
      try {
        final TransacaoResposta resposta =
            await _salva(transferenciaCriada, senha);
        _mostraMensagemDeRetorno(resposta, context);
      } catch (e) {
        _mostraMensagem(
          _respostasDialog[TransacaoResposta.desconhecido],
        );
      }
      Scaffold.of(context).hideCurrentSnackBar();
    }
  }

  Future<void> _mostraMensagemDeRetorno(
      TransacaoResposta resposta, BuildContext context) async {
    if (_respostasDialog.containsKey(resposta)) {
      await _mostraMensagem(_respostasDialog[resposta]);
      if (resposta == TransacaoResposta.sucesso) {
        Navigator.of(context).pop();
      }
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

  Future<void> _mostraMensagem(ConteudoDialog conteudo) => showDialog(
        context: context,
        builder: (context) => AvisaDialog(
          titulo: conteudo.titulo,
          mensagem: conteudo.mensagem,
          icone: conteudo.icone,
        ),
      );

  void _mostraProgresso(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Wrap(children: <Widget>[
          Progresso(
            mensagem: 'Enviando transfência',
          ),
        ]),
      ),
    );
  }
}

Map<TransacaoResposta, ConteudoDialog> _respostasDialog = {
  TransacaoResposta.sucesso: ConteudoDialog(
    'Transação sucedida!',
    'Transferência realizada com sucesso',
    Icons.done,
  ),
  TransacaoResposta.falhaAutenticacao: ConteudoDialog(
    'Transação não realizada!',
    'Senha inválida',
    Icons.error_outline,
  ),
  TransacaoResposta.desconhecido: ConteudoDialog(
    'Erro desconhecido',
    'Contate a equipe de suporte',
    Icons.error_outline,
  ),
  TransacaoResposta.duplicada: ConteudoDialog(
    'Transação não realizada!',
    'Transação já realizada',
    Icons.error_outline,
  ),
  TransacaoResposta.falhaRequisicao: ConteudoDialog(
    'Transação não realizada!',
    'Falha no envio da transação',
    Icons.error_outline,
  )
};

class ConteudoTransacaoSucesso extends ConteudoDialog {
  ConteudoTransacaoSucesso(
    String mensagem, {
    String titulo = 'Transação Sucessida!',
    IconData icone = Icons.done,
  }) : super(
          titulo,
          mensagem,
          icone,
        );
}

class ConteudoTransacaoFalha extends ConteudoDialog {
  ConteudoTransacaoFalha(
    String mensagem, {
    String titulo = 'Transação não realizada!',
    IconData icone = Icons.error_outline,
  }) : super(
          titulo,
          mensagem,
          icone,
        );
}

class ConteudoDialog {
  final String titulo;
  final String mensagem;
  final IconData icone;

  ConteudoDialog(
    this.titulo,
    this.mensagem,
    this.icone,
  );
}
