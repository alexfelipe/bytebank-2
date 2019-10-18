import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feature {
  final CodigoFeature codigo;
  final String nome;
  final IconData icone;

  Feature(
    this.codigo,
    this.nome,
    this.icone,
  );
}

//TODO fiquei em dúvida onde deixar tanto o mapa como também o enum, seja diretório ou arquivo
Map<int, Feature> todasFeatures = {
  1: Feature(
    CodigoFeature.transferir,
    'Transferir',
    Icons.monetization_on,
  ),
  2: Feature(
    CodigoFeature.historico,
    'Histórico',
    Icons.description,
  ),
  3: Feature(
    CodigoFeature.cartaoDeCredito,
    'Cartão de crédito',
    Icons.credit_card,
  ),
  4: Feature(
    CodigoFeature.ajuda,
    'Ajuda',
    Icons.help,
  ),
};

enum CodigoFeature {
  historico,
  transferir,
  cartaoDeCredito,
  ajuda,
}