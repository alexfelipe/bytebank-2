import 'package:bytebank/models/feature.dart';
import 'package:flutter/material.dart';

class ItemFeature extends StatelessWidget {
  final Function(Feature) quandoClica;
  final Feature feature;

  const ItemFeature({
    this.feature,
    this.quandoClica,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => quandoClica(feature),
          child: Container(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    feature.icone,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  Flexible(
                      child: Text(
                    feature.nome,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}