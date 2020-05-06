import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/agendamento.dart';
import 'package:forca_de_vendas/model/result_pedido.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceAgendamento{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<Agendamento>> getAllAgendamentos () async{

    Database db = await database.database;
    List<Agendamento> agendamentos = List();

    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaAgendamento} WHERE ${DatabaseCreator.tabelaAgendamentoVisitou} = 0 ORDER BY ${DatabaseCreator.tabelaAgendamentoData} ASC''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final agendamento = Agendamento.fromJson(node);
      agendamentos.add(agendamento);
    }
    return agendamentos;
  }

  static Future<Agendamento> getAgendamento(int codigo) async{
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaAgendamento}
    WHERE ${DatabaseCreator.tabelaAgendamentoId} == $codigo''';
    final data = await db.rawQuery(sql);
    final a = Agendamento.fromJson(data[0]);
    return a;
  }

  static Future <List<Agendamento>> buscaAgendamento(String busca) async {
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaAgendamento} 
    WHERE ${DatabaseCreator.tabelaAgendamentoId} LIKE "%$busca%" OR
    ${DatabaseCreator.tabelaAgendamentoData} LIKE "%$busca%"''';
    final data = await db.rawQuery(sql);
    List<Agendamento> agendamentos = List();

    for(final node in data){
      final agendamento = Agendamento.fromJson(node);
      agendamentos.add(agendamento);
    }
    return agendamentos;
  }

  static Future<int> addAgendamento(Agendamento agendamento) async {
    Database db = await database.database;

    var res = await db.insert(DatabaseCreator.tabelaAgendamento, agendamento.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  static Future<void> apagaAgendamento(Agendamento agendamento) async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaAgendamento}
    WHERE ${DatabaseCreator.tabelaAgendamentoId} == ${agendamento.id}''';
    await db.rawDelete(sql);
  }

  static Future<void> alteraEstadoAgendamento(Agendamento agendamento, int estado) async{
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaAgendamento} SET 
    ${DatabaseCreator.tabelaAgendamentoVisitou} = "$estado" WHERE ${DatabaseCreator.tabelaAgendamentoId} = ${agendamento.id}
    ''';
    await db.rawUpdate(sql);
  }

  static Future<void> alteraIdAgendamento(Agendamento agendamento, ResultPedido id) async{
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaAgendamento} SET 
    id = ${id.result} WHERE ${DatabaseCreator.tabelaAgendamentoId} == ${agendamento.id}
    ''';
    await db.rawUpdate(sql);
  }
}