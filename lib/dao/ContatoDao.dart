import 'dart:async';

import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDao {

  Future<Database> abreBanco() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        'bytebank.db',
      ),
      onCreate: (db, versao) {
        return db.execute(
          "CREATE TABLE contatos("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          " nome TEXT,"
          " numero_conta INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> insere(Contato contato) async {
    final db = await abreBanco();
    final mapa = {
      'id': contato.id,
      'nome': contato.nome,
      'numero_conta': contato.numeroConta
    };
    return db.insert('contatos', mapa);
  }

  Future<List<Contato>> todos() async {
    final db = await abreBanco();
    final List<Map<String, dynamic>> resultado = await db.query("contatos");
    return resultado.map(
      (linha) {
        return Contato(
          linha['nome'],
          linha['numero_conta'],
          id: linha['id'],
        );
      },
    ).toList();
  }
}
