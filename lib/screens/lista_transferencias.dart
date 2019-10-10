import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/transferencia_webclient.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  final List<Transferencia> _transferencias = List();

  @override
  void initState() {
    super.initState();
    buscaTodas();
  }

  void buscaTodas() async {
    final transferenciasEncontradas = await TransferenciaWebClient().todas();
    setState(() {
      _transferencias.addAll(transferenciasEncontradas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: configuraWidget());
  }

  Widget configuraWidget() {
    if (_temTransferencia()) {
      print("tranferencias $_transferencias");
      return Transferencias(_transferencias);
    }
    return Progresso();
  }

  bool _temTransferencia() => _transferencias.isNotEmpty;
}

class Transferencias extends StatelessWidget {
  final List<Transferencia> _transferencias;

  Transferencias(this._transferencias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        });
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_transferencia.contato.nome),
          Text(
              '${_transferencia.data.day}/${_transferencia.data.month}/${_transferencia.data.year}'),
        ],
      ),
    ));
  }
}
