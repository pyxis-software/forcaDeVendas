import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/produto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceProdutos{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<Produto>> getAllProdutos() async{

    Database db = await database.database;
    List<Produto> produtos = List();

    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaProdutos}''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final produto = Produto.fromJson(node);
      produtos.add(produto);
    }
    return produtos;
  }

  static Future<int> getProduto(int codigo) async{
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaProdutos}
    WHERE ${DatabaseCreator.produtoIdProduto} == $codigo''';
    final data = await db.rawQuery(sql);
    int count = data[0].values.elementAt(0);
    return count;
  }

  static Future <List<Produto>> buscaProdutos(String busca) async {
    Database db = await database.database;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaProdutos} 
    WHERE ${DatabaseCreator.produtoIdProduto} LIKE "%$busca%" OR
    ${DatabaseCreator.produtoDescricao} LIKE "%$busca%" OR
    ${DatabaseCreator.produtoRefFabrica} LIKE "%$busca%"''';
    final data = await db.rawQuery(sql);
    List<Produto> produtos = List();

    for(final node in data){
      final produto = Produto.fromJson(node);
      produtos.add(produto);
    }
    return produtos;
  }

  static Future<int> addProduto(Produto p) async {
    Database db = await database.database;

    var res = await db.insert(DatabaseCreator.tabelaProdutos, p.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

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

  static contClientes() async{
    Database db = await database.database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaClientes}''');

    int count = data[0].values.elementAt(0);
    return count;
  }
}