import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/feature.dart';
import 'package:bytebank/webclient/features_webclient.dart';
import 'package:flutter/material.dart';

import 'item.dart';

const _featureHistorico = 'historico';
const _tituloFeatureHistorico = 'Histórico';

const _featureTransferir = 'transferir';
const _tituloFeatureTransferir = "Transferir";

const _featureCartaoDeCredito = 'cartao de credito';
const _tituloFeatureCartaoDeCredito = 'Cartão de crédito';

const _featureAjuda = 'ajuda';
const _tituloFeatureAjuda = 'Ajuda';

class ListaFeatures extends StatefulWidget {
  final Function() quandoClicaTransacoes;
  final Function() quandoClicaContatos;

  const ListaFeatures({
    this.quandoClicaTransacoes,
    this.quandoClicaContatos,
  });

  @override
  State<StatefulWidget> createState() {
    return _ListaFeaturesState();
  }
}

class _ListaFeaturesState extends State<ListaFeatures> {
  List<ItemFeature> _features = List();

  @override
  void initState() {
    super.initState();
    _buscaTodas();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: _tentaCarregarFeatures(),
      ),
    );
  }

  Widget _tentaCarregarFeatures() {
    if (_features.isEmpty) {
      return Progresso();
    }
    return Features(_features);
  }

  _buscaTodas() async {
    final List<Feature> features = await FeatureWebClient().todas();
    final itemFeaturesDisponiveis = _carregaFeaturesDisponiveis(features);
    setState(() {
      _features.addAll(itemFeaturesDisponiveis);
    });
  }

  List<ItemFeature> _carregaFeaturesDisponiveis(List<Feature> features) {
    return features
        .map((feature) => _devolveItemFeature(feature))
        .where((itemFeature) => itemFeature != null)
        .toList();
  }

  ItemFeature _devolveItemFeature(Feature feature) {
    switch (feature.nome) {
      case _featureHistorico:
        return ItemFeature(
          quandoClica: () => widget.quandoClicaTransacoes(),
          icone: Icons.description,
          texto: _tituloFeatureHistorico,
        );
      case _featureTransferir:
        return ItemFeature(
          quandoClica: () => widget.quandoClicaContatos(),
          icone: Icons.monetization_on,
          texto: _tituloFeatureTransferir,
        );
      case _featureCartaoDeCredito:
        return ItemFeature(
          icone: Icons.credit_card,
          texto: _tituloFeatureCartaoDeCredito,
        );
      case _featureAjuda:
        return ItemFeature(
          icone: Icons.help,
          texto: _tituloFeatureAjuda,
        );
    }
    return null;
  }

}

class Features extends StatelessWidget {
  final List<ItemFeature> _itemFeatures;

  Features(this._itemFeatures);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _itemFeatures.length,
      itemBuilder: (context, posicao) {
        return _itemFeatures[posicao];
      },
    );
  }
}
