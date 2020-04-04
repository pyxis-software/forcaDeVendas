import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceCliente{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<Cliente>> getAllClientes() async{

    Database db = await database.database;
    List<Cliente> clientes = List();

    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes}''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final cliente = Cliente.fromJson(node);
      clientes.add(cliente);
    }
    return clientes;
  }

  static Future<Cliente> getCliente(int id) async{
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes}
    WHERE ${DatabaseCreator.clienteId} == $id''';
    final data = await db.rawQuery(sql);

    final pedido = Cliente.fromJson(data[0]);
    return pedido;
  }

  static Future <List<Cliente>> buscaCliente(String busca) async {
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes} 
    WHERE ${DatabaseCreator.clienteNomeRazao} LIKE "%$busca%" OR 
    ${DatabaseCreator.clienteApelido} LIKE "%$busca%" OR 
    ${DatabaseCreator.clienteCpf} LIKE "%$busca%" OR 
    ${DatabaseCreator.clienteId} LIKE "%$busca%"''';
    final data = await db.rawQuery(sql);
    List<Cliente> clientes = List();

    for(final node in data){
      final cliente = Cliente.fromJson(node);
      clientes.add(cliente);
    }
    return clientes;
  }

  static Future<int> addCliente(Cliente c) async {
    Database db = await database.database;
    final result = await db.insert(DatabaseCreator.tabelaClientes, c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  static Future<int> deleteCliente(Cliente c) async{
    Database db = await database.database;
    final result = await db.delete(DatabaseCreator.tabelaClientes, where: 'id = ?', whereArgs: [c.id]);
    return result;
  }

  static contClientes() async{
    Database db = await database.database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaClientes}''');
    int count = data[0].values.elementAt(0);
    return count;
  }
}