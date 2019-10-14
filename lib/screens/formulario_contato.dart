import 'package:bytebank/components/editor.dart';
import 'package:bytebank/dao/ContatoDao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Novo contato';

const _rotuloCampoNome = 'Nome completo';
const _rotuloCampoNumeroConta = 'Número da conta';

const _tituloBotaoCriar = 'Criar';

class FormularioContato extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormularioContatoState();
  }
}

class _FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();
  final ContatoDao _dao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _nomeController,
              rotulo: _rotuloCampoNome,
              tipoTeclado: TextInputType.text,
            ),
            Editor(
              controlador: _numeroContaController,
              rotulo: _rotuloCampoNumeroConta,
              tipoTeclado: TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text(_tituloBotaoCriar),
                  onPressed: () {
                    final Contato contato = _criaContato();
                    _salva(contato);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _salva(Contato contato) async {
    final id = await _dao.insere(contato);
    Navigator.pop(context, id);
  }

  Contato _criaContato() {
    final nome = _nomeController.text;
    final numeroConta = int.tryParse(_numeroContaController.text);
    return Contato(nome, numeroConta);
  }
}