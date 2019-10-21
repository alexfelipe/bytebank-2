import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webclient/transferencia_webclient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _tituloAppBar = 'Histórico';

//TODO refresh com scroll e
class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListaTransferenciasState();
  }
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  List<Transferencia> _transferencias;
  final TransferenciaWebClient _webClient = TransferenciaWebClient();

  @override
  void initState() {
    super.initState();
    _buscaTodas();
  }

  void _buscaTodas() async {
    try {
      final transferenciasEncontradas = await _webClient.todas();
      setState(() {
        _transferencias = transferenciasEncontradas;
      });
    } catch (e) {
      print(e);
      setState(() {
        _transferencias = List();
      });
    }
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
    if (_transferencias != null) {
      if (_transferencias.isEmpty) {
        //TODO como adicionar um RefreshIndicator em Widgets mantendo o visual do Center
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.money_off,
                size: 80,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Não há transferências",
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        );
      }
      return _Transferencias(_transferencias, () => _buscaTodas());
    }
    return Progresso();
  }
}

class _Transferencias extends StatelessWidget {
  final List<Transferencia> _transferencias;
  final Function quandoAtualizaPorRolagem;

  _Transferencias(
    this._transferencias,
    this.quandoAtualizaPorRolagem,
  );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _configuraLista(),
      onRefresh: () => quandoAtualizaPorRolagem(),
    );
  }

  Widget _configuraLista() {
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
        title: Text(_formataParaMoedaBrasileira(_transferencia.valor)),
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

  String _formataParaMoedaBrasileira(double valor) =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);

  String _formataParaDataHoraBrasileira(DateTime dataHora) =>
      DateFormat('dd/MM/yy hh:mm').format(dataHora);
}
