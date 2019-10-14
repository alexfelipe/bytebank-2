import 'package:bytebank/components/features/lista.dart';
import 'package:bytebank/components/quadro.dart';
import 'package:bytebank/models/feature.dart';
import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/material.dart';
import 'lista_contatos.dart';

const _imagemDashboard = 'assets/logo-bytebank.png';

const _tituloAppBar = 'Dashboard';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      /**TODO para manter o dashboard com o mesmo visual e
       * com comportamentos de scroll tive que usar esse exemplo
       * que peguei na página da documentação,
       * é necessário realizar esse procedimento completo?
       * */
      body: LayoutBuilder(builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Quadro(
                  altura: 400.0,
                  caminhoImagem: _imagemDashboard,
                ),
                ListaFeatures(
                  featureClicada: (featureSelecionada) {
                    //TODO fiz da maneira mais simple, se tiver sugestão para algo mais sucinto e prático é só avisar
                    switch (featureSelecionada.codigo) {
                      case CodigoFeature.transferir:
                        _vaiParaListaContatos(context);
                        break;
                      case CodigoFeature.historico:
                        _vaiParaListaTransferencias(context);
                        break;
                      case CodigoFeature.cartaoDeCredito:
                        print("cartão de crédito selecionado");
                        break;
                      case CodigoFeature.ajuda:
                        print("ajuda selecionado");
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  //TODO todas as navegações eu usei esse estilo simples
  _vaiParaListaContatos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ListaContatos();
      },
    ));
  }

  _vaiParaListaTransferencias(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ListaTransferencias();
      },
    ));
  }
}
