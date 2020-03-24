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
    WHERE ${DatabaseCreator.id} == $id''';
    final data = await db.rawQuery(sql);

    final pedido = Cliente.fromJson(data[0]);
    return pedido;
  }

  static Future <List<Cliente>> buscaCliente(String busca) async {
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes} 
    WHERE ${DatabaseCreator.clienteNomeRazao} LIKE "%$busca%" OR
    ${DatabaseCreator.clienteApelido} LIKE "%$busca%" OR
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

  /*

  static Future<void> deletePedido(Cliente c) async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaClientes}
    WHERE ${DatabaseCreator.codigo} == ${c.codigo}''';
    final result = await db.rawDelete(sql);
  }

  static Future<void> updatePedido(Cliente c) async{
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaClientes} SET 
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

  static contClientes() async{
    Database db = await database.database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaClientes}''');

    int count = data[0].values.elementAt(0);
    return count;
  }
}