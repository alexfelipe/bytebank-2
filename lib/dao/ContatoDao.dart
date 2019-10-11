import 'dart:async';

import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _nomeBanco = 'bytebank.db';
const int _versao = 1;

const String _tabelaContatos = 'contatos';
const String _campoId = 'id';
const String _campoNome = 'nome';
const String _campoNumeroConta = 'numero_conta';

const String _sqlTabelaContatos = 'CREATE TABLE $_tabelaContatos('
    '$_campoId INTEGER PRIMARY KEY AUTOINCREMENT,'
    ' $_campoNome TEXT,'
    ' $_campoNumeroConta INTEGER)';

//TODO usei o sqflite, avisa se tiver outra lib recomendada
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
    //TODO se tiver outra técnica mais sucinta para gerar a lista, manda tbm
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
