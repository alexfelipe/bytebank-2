import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/transferencia_webclient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _tituloAppBar = 'Histórico';

class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListaTransferenciasState();
  }
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  final List<Transferencia> _transferencias = List();

  @override
  void initState() {
    super.initState();
    buscaTodas();
  }

  void buscaTodas() async {
    final List<Transferencia> transferencias = List();
    try {
      final transferenciasEncontradas = await TransferenciaWebClient().todas();
      transferencias.addAll(transferenciasEncontradas);
    } catch (e) {
      print(e);
    }

    setState(() {
      if (transferencias.isNotEmpty) {
        _transferencias.addAll(transferencias);
      } else {
        _transferencias.add(
          Transferencia(
            20.0,
            Contato(
              'alex',
              1000,
            ),
            data: DateTime.now(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: _configuraWidget());
  }

  Widget _configuraWidget() {
    if (_temTransferencia()) {
      return _Transferencias(_transferencias);
    }
    return Progresso();
  }

  bool _temTransferencia() => _transferencias.isNotEmpty;
}

class _Transferencias extends StatelessWidget {
  final List<Transferencia> _transferencias;

  _Transferencias(this._transferencias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return _ItemTransferencia(transferencia);
        });
  }
}

class _ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  _ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_transferencia.contato.nome),
            Text(_formataParaDataHoraBrasileira(_transferencia.data)),
          ],
        ),
      ),
    );
  }

  String _formataParaDataHoraBrasileira(DateTime dataHora) {
    return new DateFormat('dd/MM/yy hh:mm').format(dataHora);
  }
}
