import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/models/feature.dart';
import 'package:bytebank/webclient/features_webclient.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class ListaFeatures extends StatefulWidget {
  final Function(Feature) featureClicada;

  const ListaFeatures({this.featureClicada});

  @override
  State<StatefulWidget> createState() {
    return _ListaFeaturesState();
  }
}

class _ListaFeaturesState extends State<ListaFeatures> {
  final List<ItemFeature> _features = List();

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
    final List<Feature> features = List();

    //TODO adicionei o try catch devido às exceptions, em relação os prints de exceptions, costumam usar o debugPrint/print ou tem outra abordagem?
    try {
      features.addAll(await FeatureWebClient().todas());
    } catch (e) {
      print(e);
    }

    final itemFeaturesDisponiveis =
        features.map((feature) => _devolveItemFeature(feature)).toList();

    if (itemFeaturesDisponiveis.isEmpty) {
      itemFeaturesDisponiveis.add(_devolveItemFeature(todasFeatures[1]));
      itemFeaturesDisponiveis.add(_devolveItemFeature(todasFeatures[2]));
    }

    setState(() {
      _features.addAll(itemFeaturesDisponiveis);
    });
  }

  //TODO Tem algum pattern para usar esse tipo de solução?
  ItemFeature _devolveItemFeature(Feature feature) {
    return ItemFeature(
      feature: feature,
      quandoClica: widget.featureClicada,
    );
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
