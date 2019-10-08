import 'package:bytebank/components/features/lista.dart';
import 'package:bytebank/dao/ContatoDao.dart';
import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/material.dart';

import 'lista_contatos.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContatoDao().testaBanco();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: Image.asset(
                  'assets/bitcoin.jpg',
                  fit: BoxFit.cover,
                ),
                height: 300,
                width: double.maxFinite,
              ),
            ),
            ListaFeatures(
              quandoClicaContatos: () => vaiParaListaContatos(context),
              quandoClicaTransacoes: () => vaiParaListaTransferencias(context),
            ),
          ],
        ),
      ),
    );
  }

  vaiParaListaContatos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ListaContatos();
      },
    ));
  }

  vaiParaListaTransferencias(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ListaTransferencias();
      },
    ));
  }
}
