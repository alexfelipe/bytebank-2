import 'package:flutter/material.dart';

class ItemFeature extends StatelessWidget {
  final IconData icone;
  final String texto;
  final Function() quandoClica;

  const ItemFeature({
    this.icone,
    this.texto,
    this.quandoClica,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => quandoClica(),
          child: Container(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    icone,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  Flexible(
                      child: Text(
                    texto,
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
