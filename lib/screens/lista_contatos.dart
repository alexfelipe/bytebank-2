import 'package:bytebank/dao/ContatoDao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario_contato.dart';

const _tituloAppBar = 'Transferir';

class ListaContatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListaContatosState();
  }
}

class _ListaContatosState extends State<ListaContatos> {
  final List<Contato> _contatos = List();
  final ContatoDao _dao = ContatoDao();

  @override
  void initState() {
    super.initState();
    _buscaContatos();
  }

  Future _buscaContatos() async {
    final contatosEncontrados = await _dao.todos();
    setState(() {
      this._contatos.addAll(contatosEncontrados);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: _contatos.length,
        itemBuilder: (context, posicao) {
          final contato = _contatos[posicao];
          return Card(
            child: ListTile(
              onTap: () => _vaiParaFormularioTransferencia(contato),
              title: Text(
                contato.nome,
                style: TextStyle(fontSize: 24.0),
              ),
              subtitle: Text('${contato.numeroConta}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _vaiParaFormularioContato(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _vaiParaFormularioTransferencia(Contato contato) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return FormularioTransferencia(contato);
      },
    ));
  }

  _vaiParaFormularioContato(BuildContext context) async {
    final int idContato = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FormularioContato(),
    ));
    if (idContato != null) {
      setState(() {
        _atualiza();
      });
    }
  }

  Future _atualiza() async {
    _contatos.clear();
    final contatosNovos = await _dao.todos();
    _contatos.addAll(contatosNovos);
  }
}
