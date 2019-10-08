import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'formulario_contato.dart';

class ListaContatos extends StatelessWidget {
  final List<Contato> contatos = List();

  ListaContatos() {
    contatos.addAll(List<Contato>.generate(10, (i) {
      return Contato("nome ${i + 1}", i);
    }));
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
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    contato.nome,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  subtitle: Text('${Random().nextInt(9999)}'),
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

  vaiParaFormulario(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FormularioContato(),
    ));
  }
}
