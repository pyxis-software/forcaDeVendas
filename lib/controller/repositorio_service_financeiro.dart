import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/financeiro.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceFinanceiro{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<FinanceiroCliente>> getAllClienteFinanceiro(int idCliente) async{
    Database db = await database.database;
    List<FinanceiroCliente> financeiros = List();
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientesFinanceiro}
    WHERE ${DatabaseCreator.tabelaClientesFinanceiroIdCliente} = $idCliente''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final fin = FinanceiroCliente.fromJson(node);
      financeiros.add(fin);
    }
    return financeiros;
  }

  static Future<int> addFinanceiro(FinanceiroCliente financeiro) async {
    Database db = await database.database;
    var res = await db.insert(DatabaseCreator.tabelaClientesFinanceiro, financeiro.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  static contFinanceiro(int idCliente) async{
    Database db = await database.database;
    final sql = '''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaClientesFinanceiro}
    WHERE ${DatabaseCreator.tabelaClientesFinanceiroIdCliente} = $idCliente''';
    final data = await db.rawQuery(sql);
    int count = data[0].values.elementAt(0);
    return count;
  }
  //Apaga todos os registros
  static Future<void> deleteFromTable () async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaClientesFinanceiro}''';
    final data = await db.rawQuery(sql);
  }
}