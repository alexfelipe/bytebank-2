import 'package:bytebank/components/features/lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: Image.asset(
                  'assets/bitcoin.jpg',
                  fit: BoxFit.fill,
                ),
                height: 300,
                width: double.maxFinite,
              ),
            ),
            ListaFeatures(),
          ],
        ),
      ),
    );
  }
}
