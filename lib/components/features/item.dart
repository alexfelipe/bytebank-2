import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final IconData icone;
  final String texto;

  const FeatureItem({this.icone, this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
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
              ),
              Flexible(
                  child: Text(
                texto,
                style: TextStyle(fontSize: 16.0),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
