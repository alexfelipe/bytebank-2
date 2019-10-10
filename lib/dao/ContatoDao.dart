import 'dart:async';

import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String _nomeBanco = 'bytebank.db';
final int _versao = 1;

final String _tabelaContatos = 'contatos';
final String _campoId = 'id';
final String _campoNome = 'nome';
final String _campoNumeroConta = 'numero_conta';

final String _sqlTabelaContatos = 'CREATE TABLE $_tabelaContatos('
    '$_campoId INTEGER PRIMARY KEY AUTOINCREMENT,'
    ' $_campoNome TEXT,'
    ' $_campoNumeroConta INTEGER)';

class ContatoDao {
  Future<Database> _abreBanco() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        _nomeBanco,
      ),
      onCreate: (db, versao) {
        return db.execute(
          _sqlTabelaContatos,
        );
      },
      version: _versao,
    );
  }

  Future<int> insere(Contato contato) async {
    final Database db = await _abreBanco();
    final Map<String, dynamic> mapaContato = {
      _campoId: contato.id,
      _campoNome: contato.nome,
      _campoNumeroConta: contato.numeroConta
    };
    return db.insert(_tabelaContatos, mapaContato);
  }

  Future<List<Contato>> todos() async {
    final Database db = await _abreBanco();
    final List<Map<String, dynamic>> resultado =
        await db.query(_tabelaContatos);
    return List.generate(resultado.length, (posicao) {
      final linha = resultado[posicao];
      return Contato(
        linha[_campoNome],
        linha[_campoNumeroConta],
        id: linha[_campoId],
      );
    });
  }
}
