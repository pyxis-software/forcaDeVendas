import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/clientes_status.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceClientesStatus{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<ClienteStatus>> getAllStatusCliente() async{

    Database db = await database.database;
    List<ClienteStatus> status = List();

    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientesStatus}''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final st = ClienteStatus.fromJson(node);
      status.add(st);
    }
    return status;
  }

  static Future<ClienteStatus> getClienteStatus(int id) async{
    Database db = await database.database;
    ClienteStatus cs;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientesStatus}
    WHERE ${DatabaseCreator.tabelaClientesStatusId} == $id''';
    final data = await db.rawQuery(sql);
    data.map((f){
      cs = ClienteStatus.fromJson(f);
    });
    return cs;
  }

  static Future <List<ClienteStatus>> buscaClintesStatus(String busca) async {
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientesStatus} 
    WHERE ${DatabaseCreator.tabelaClientesStatusDescricao} LIKE "%$busca%" OR
    ${DatabaseCreator.tabelaClientesStatusBloqueiaPessoa} LIKE "%$busca%"''';
    final data = await db.rawQuery(sql);
    List<ClienteStatus> statusClientes = List();

    for(final node in data){
      final status = ClienteStatus.fromJson(node);
      statusClientes.add(status);
    }
    return statusClientes;
  }

  static Future<int> addStatusCliente(ClienteStatus cs) async {
    Database db = await database.database;

    var res = await db.insert(DatabaseCreator.tabelaClientesStatus, cs.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
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
  static contClienteStatus() async{
    Database db = await database.database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaClientesStatus}''');

    int count = data[0].values.elementAt(0);
    return count;
  }
}