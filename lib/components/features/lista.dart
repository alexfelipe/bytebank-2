import 'package:flutter/material.dart';

import 'item.dart';

class ListaFeatures extends StatelessWidget {
  final Function() quandoClicaTransacoes;
  final Function() quandoClicaContatos;

  const ListaFeatures({
    this.quandoClicaTransacoes,
    this.quandoClicaContatos,
  });

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
              quandoClica: () => quandoClicaTransacoes(),
              icone: Icons.monetization_on,
              texto: 'Transferência',
            ),
            FeatureItem(
              quandoClica: () => quandoClicaContatos(),
              icone: Icons.people,
              texto: 'Contatos',
            ),
          ],
        ),
      ),
    );
  }
}
