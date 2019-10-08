import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = List();

  ListaTransferencias() {
    _transferencias.addAll(
      List.generate(
        10,
        (i) => Transferencia(
          Random().nextInt(999).toDouble(),
          Random().nextInt(9999),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}
