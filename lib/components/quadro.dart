import 'package:flutter/cupertino.dart';

class Quadro extends StatelessWidget {
  final String caminhoImagem;
  final double altura;

  Quadro({
    @required this.altura,
    this.caminhoImagem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Image.asset(
          caminhoImagem,
          fit: BoxFit.cover,
        ),
        height: altura,
        width: double.maxFinite,
      ),
    );
  }
}
