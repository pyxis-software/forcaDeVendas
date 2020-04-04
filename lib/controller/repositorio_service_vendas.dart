import 'dart:math';

import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:forca_de_vendas/model/produto.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/model/venda.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceVendas{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<Venda>> getVendasEmAberto() async{
    Database db = await database.database;
    List<Venda> vendas = List();
     String zero = '0';
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaVenda}
    WHERE ${DatabaseCreator.vendaStatus} == $zero''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final venda = Venda.fromJson(node);
      vendas.add(venda);
    }
    return vendas;
  }

  static Future<List<Venda>> getVendasFaturado() async{
    Database db = await database.database;
    List<Venda> vendas = List();
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaVenda}
    WHERE ${DatabaseCreator.vendaStatus} == 2
    ''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final venda = Venda.fromJson(node);
      vendas.add(venda);
    }
    return vendas;
  }

  //Adiciona uma venda
  static Future<int> addVenda(Venda venda) async{
    Database db = await database.database;
    var res = db.insert(DatabaseCreator.tabelaVenda, venda.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  //adiciona cliente a venda
  static Future<void> addCliente(Cliente cliente, id, Municipio municipio) async{
    final nomeCidade = "${municipio.municipioNome} - ${municipio.municipioEstado}";
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaVenda} SET id_cliente = '${cliente.id}', nome_razao = '${cliente.nomeRazao}', clienteCidade = '$nomeCidade' WHERE ${DatabaseCreator.vendasId} == $id''';
    db.rawUpdate(sql);
  }

  //altera valor da venda
  static Future<void> alteraValorVenda (total_bruto, total_liquido, total_desconto, id) async{
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaVenda} SET tot_bruto = $total_bruto, tot_desc_vlr = $total_desconto, tot_liquido = $total_liquido WHERE ${DatabaseCreator.vendasId} == $id''';
    db.rawUpdate(sql);
  }

  //altera a forma de pagamento da venda
  static Future<void> alteraFormaPagamento (forma, id) async{
    Database db = await database.database;
    final sql = '''UPDATE ${DatabaseCreator.tabelaVenda} SET id_fpagto = $forma WHERE ${DatabaseCreator.vendasId} == $id''';
    db.rawUpdate(sql);
  }

  //Adiciona item na venda
  static Future<int> addItenVenda (Produto produto, idVenda, qtd, Usuario usuario) async{
    Database db = await database.database;
    var randomizer = new Random();
    int id = randomizer.nextInt(10000);
    Map<String, dynamic> toJson() => {
      "id" : id,
      "id_empresa": usuario.empresaId,
      "id_produto": produto.idProduto,
      "produto_descricao": produto.produtoDescricao,
      "ref_fabrica": produto.refFabrica,
      "gtin": produto.gtin,
      "aplicacao": produto.aplicacao,
      "peso": produto.peso,
      "id_fabricante": produto.idFabricante,
      "fabricante_nome": produto.fabricanteNome,
      "id_grupo": produto.idGrupo,
      "grupo_nome": produto.grupoNome,
      "id_sub_grupo": produto.idSubGrupo,
      "subgrupo_nome": produto.subgrupoNome,
      "id_ncm": produto.idNcm,
      "grade": produto.grade,
      "pvenda": produto.pvenda,
      "saldo_geral": produto.saldoGeral.toInt(),
      "produto_unidade": produto.produtoUnidade,
      "id_venda": idVenda,
      "qtd_venda": qtd
    };

    //
    Iten iten = Iten.fromMap(toJson());
    final res = db.insert(DatabaseCreator.tabelaItensPedido, iten.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  //buscando os itens da venda
  static Future<List<Iten>> getItensVenda(int idVenda) async{
    Database db = await database.database;
    List<Iten> itens = List();
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaItensPedido}
    WHERE ${DatabaseCreator.tabelaItensIdVenda} == $idVenda''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final iten = Iten.fromJson(node);
      itens.add(iten);
    }
    return itens;
  }

  //revome todos os itens da venda
  static Future<void> removeItens(Venda venda) async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaItensPedido} WHERE ${DatabaseCreator.tabelaItensIdVenda} == ${venda.id}''';
    db.rawDelete(sql);
  }

  //remove 1 iten da venda
  static Future<void> removeIten(Iten iten) async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaItensPedido} WHERE ${DatabaseCreator.tabelaItensPedidoId} == ${iten.id}''';
    db.rawDelete(sql);
  }


  //Removendo a venda
  static Future<void> removeVenda(Venda venda) async{
    Database db = await database.database;
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaVenda} WHERE ${DatabaseCreator.vendasId} == ${venda.id}''';
    db.rawDelete(sql);
  }


}