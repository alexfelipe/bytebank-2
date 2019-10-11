import 'package:bytebank/components/features/lista.dart';
import 'package:bytebank/components/quadro.dart';
import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/material.dart';

import 'lista_contatos.dart';

const _imagemDashboard = 'assets/logo-bytebank.png';

const _tituloAppBar = 'Dashboard';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Quadro(
              altura: 400.0,
              caminhoImagem: _imagemDashboard,
            ),
            ListaFeatures(
              quandoClicaContatos: () => _vaiParaListaContatos(context),
              quandoClicaTransacoes: () => _vaiParaListaTransferencias(context),
            ),
          ],
        ),
      ),
    );
  }

  //TODO todas as navegações eu usei esse estilo simples
  _vaiParaListaContatos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ListaContatos();
      },
    ));
  }

  _vaiParaListaTransferencias(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ListaTransferencias();
      },
    ));
  }
}
