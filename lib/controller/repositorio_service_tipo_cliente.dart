import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/forma_pagamento.dart';
import 'package:forca_de_vendas/model/tipo_cliente.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceTipoCliente{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<TipoCliente>> getAllTipoCliente() async{

    Database db = await database.database;
    List<TipoCliente> tipos = new List<TipoCliente>();

    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaTipoClientes}''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final tipo = TipoCliente.fromJson(node);
      tipos.add(tipo);
    }
    return tipos;
  }

  static Future<TipoCliente> getTipoCliente(int id) async{
    Database db = await database.database;
    TipoCliente tp;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaTipoClientes}
    WHERE ${DatabaseCreator.clienteTipoId} == $id''';
    final data = await db.rawQuery(sql);
    data.map((f){
      tp = TipoCliente.fromJson(f);
    });
    return tp;
  }

  static Future<int> addTipoCliente(TipoCliente tp) async {
    Database db = await database.database;

    var res = await db.insert(DatabaseCreator.tabelaTipoClientes, tp.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }
  /*
  static Future<void> deletePedido(Cliente c) async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaClientes}
    WHERE ${DatabaseCreator.codigo} == ${c.codigo}''';
    final result = await db.rawDelete(sql);
  }

  static Future<void> updatePedido(Cliente c) async{
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaClientes} SET 1
    ${DatabaseCreator.clienteCPF} = "${c.cep}",
    ${DatabaseCreator.clienteNome} = "${c.nome}",
    ${DatabaseCreator.clienteEndereco} = "${c.endereco}",
    ${DatabaseCreator.clienteBairro} = ${c.bairro},
    ${DatabaseCreator.clienteCidade} = "${c.cidade}",
    ${DatabaseCreator.clienteEstado} = "${c.estado}",
    ${DatabaseCreator.clienteCEP} = "${c.cep}",
    ${DatabaseCreator.clienteTelefone} = "${c.telefone}",
    ${DatabaseCreator.clienteEstado} = "${c.estado}",
    WHERE ${DatabaseCreator.codigo} = ${c.codigo}
    ''';

    final result = await db.rawUpdate(sql);
  }
  */

  static contFormasPagamento() async{
    Database db = await database.database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaPagamentos}''');
    int count = data[0].values.elementAt(0);
    return count;
  }
}