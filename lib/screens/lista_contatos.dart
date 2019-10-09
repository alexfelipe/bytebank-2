import 'package:bytebank/dao/ContatoDao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/formulario_transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario_contato.dart';

class ListaContatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaContatosState();
  }
}

class ListaContatosState extends State<ListaContatos> {
  final List<Contato> contatos = List();
  final ContatoDao dao = ContatoDao();

  @override
  void initState() {
    super.initState();
    buscaContatos();
  }

  Future buscaContatos() async {
    final contatos = await dao.todos();
    setState(() {
      this.contatos.addAll(contatos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, posicao) {
          final contato = contatos[posicao];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return FormularioTransferencia(contato);
                },
              ));
            },
            child: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      contato.nome,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    subtitle: Text('${contato.numeroConta}'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vaiParaFormulario(context),
        child: Icon(Icons.add),
      ),
    );
  }

  vaiParaFormulario(BuildContext context) async {
    final int idContato = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FormularioContato(),
    ));
    if (idContato != null) {
      setState(() {
        atualiza();
      });
    }
  }

  Future atualiza() async {
    contatos.clear();
    final contatosNovos = await dao.todos();
    contatos.addAll(contatosNovos);
  }
}
