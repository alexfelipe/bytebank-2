import 'package:bytebank/models/feature.dart';
import 'package:bytebank/webclient/features_webclient.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class ListaFeatures extends StatefulWidget {
  final Function() quandoClicaTransacoes;
  final Function() quandoClicaContatos;

  const ListaFeatures({
    this.quandoClicaTransacoes,
    this.quandoClicaContatos,
  });

  @override
  State<StatefulWidget> createState() {
    return ListaFeaturesState();
  }
}

class ListaFeaturesState extends State<ListaFeatures> {
  List<Feature> _features = List();

  @override
  void initState() {
    super.initState();
    buscaTodas();
  }

  buscaTodas() async {
    final featureEncontradas = await FeatureWebClient().todas();
    setState(() {
      _features.addAll(featureEncontradas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, posicao) {
            final feature = _features[posicao];
            print(feature);
            return criaFeature(feature);
          },
          itemCount: _features.length,
        ),
      ),
    );
  }

  ItemFeature criaFeature(Feature feature) {
    switch (feature.nome) {
      case 'transferencias':
        return ItemFeature(
          quandoClica: () => widget.quandoClicaTransacoes(),
          icone: Icons.monetization_on,
          texto: 'Transferência',
        );
      case 'contatos':
        return ItemFeature(
          quandoClica: () => widget.quandoClicaContatos(),
          icone: Icons.people,
          texto: 'Contatos',
        );
      case 'cartao de credito':
        return ItemFeature(
          icone: Icons.credit_card,
          texto: 'Cartão de crédito',
        );
      case 'ajuda':
        return ItemFeature(
          icone: Icons.help,
          texto: 'Ajuda',
        );
    }
    return null;
  }
}
