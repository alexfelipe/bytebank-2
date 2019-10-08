import 'package:flutter/material.dart';

import 'item.dart';

class ListaFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            FeatureItem(
              icone: Icons.monetization_on,
              texto: 'Transferência',
            ),
            FeatureItem(
              icone: Icons.people,
              texto: 'Contatos',
            ),
          ],
        ),
      ),
    );
  }
}
