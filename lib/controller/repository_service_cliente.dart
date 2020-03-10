import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/cliente.dart';

class RepositoryServiceCliente{
  static Future <List<Cliente>> getAllClientes() async{
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes}''';
    final data = await db.rawQuery(sql);
    List<Cliente> clientes = List();

    for(final node in data){
      final cliente = Cliente.fromJson(node);
      clientes.add(cliente);
    }
    return clientes;
  }

  static Future<Cliente> getCliente(int id) async{
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes}
    WHERE ${DatabaseCreator.id} == $id''';
    final data = await db.rawQuery(sql);

    final pedido = Cliente.fromJson(data[0]);
    return pedido;
  }

  static Future <List<Cliente>> buscaCliente(String busca) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaClientes} 
    WHERE ${DatabaseCreator.clienteNome} LIKE "%$busca%" OR
    ${DatabaseCreator.clienteCodigo} LIKE "%$busca%" OR
    ${DatabaseCreator.clienteCPF} LIKE "%$busca%"''';
    final data = await db.rawQuery(sql);
    List<Cliente> clientes = List();

    for(final node in data){
      final cliente = Cliente.fromJson(node);
      clientes.add(cliente);
    }
    return clientes;
  }

  static Future<void> addCliente(Cliente c) async {
    final sql = '''INSERT INTO ${DatabaseCreator.tabelaClientes}]
    (
      ${DatabaseCreator.clienteCodigo},
      ${DatabaseCreator.clienteCPF},
      ${DatabaseCreator.clienteNome},
      ${DatabaseCreator.clienteEndereco},
      ${DatabaseCreator.clienteBairro},
      ${DatabaseCreator.clienteCidade},
      ${DatabaseCreator.clienteEstado},
      ${DatabaseCreator.clienteCEP},
      ${DatabaseCreator.clienteTelefone},
      ${DatabaseCreator.clienteCelular},

    ) VALUES (
      ${c.codigo},
      ${c.cpf},
      ${c.nome},
      ${c.endereco},
      ${c.bairro},
      ${c.cidade},
      ${c.estado},
      ${c.cep},
      ${c.telefone},
      ${c.celular},
    )
    ''';
    final result = await db.rawInsert(sql);
    DatabaseCreator.databaseLog("Cliente Adicionado", sql, null, result);
  }

  static Future<void> deletePedido(Cliente c) async{
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaClientes}
    WHERE ${DatabaseCreator.codigo} == ${c.codigo}''';
    final result = await db.rawDelete(sql);
    DatabaseCreator.databaseLog("Cliente deletado", sql, null, result);
  }

  static Future<void> updatePedido(Cliente c) async{
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
    DatabaseCreator.databaseLog("Cliente Atualizado", sql, null, result);
  }

  static Future<int> contClientes() async{
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaClientes}''');

    int count = data[0].values.elementAt(0);
    return count;
  }
}