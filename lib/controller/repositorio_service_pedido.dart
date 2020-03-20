import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/pedido.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class RepositoryServicePedido{
  static Future <List<Pedido>> getAllPedidos() async{
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaPedidos}''';
    final data = await db.rawQuery(sql);
    List<Pedido> pedidos = List();


    for(final node in data){
      final pedido = Pedido.fromJson(node);
      pedidos.add(pedido);
    }
    db.close();
    db = null;
    return pedidos;
  }

  Future<Pedido> getPedido(int id) async{
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaPedidos}
    WHERE ${DatabaseCreator.id} == $id''';
    final data = await db.rawQuery(sql);

    final pedido = Pedido.fromJson(data[0]);
    return pedido;
  }

  static Future<void> addPedido(Pedido p) async {
    final sql = '''INSERT INTO ${DatabaseCreator.tabelaPedidos}]
    (
      ${DatabaseCreator.nome},
      ${DatabaseCreator.codigo},
      ${DatabaseCreator.cidade},
      ${DatabaseCreator.valor},
      ${DatabaseCreator.data},
      ${DatabaseCreator.isFaturado},
    ) VALUES (
      ${p.nome},
      ${p.codigo},
      ${p.cidade},
      ${p.valor},
      0,
    )
    ''';
    final result = await db.rawInsert(sql);
  }

  static Future<void> deletePedido(Pedido p) async{
    final sql = '''DELETE FROM ${DatabaseCreator.tabelaPedidos}
    WHERE ${DatabaseCreator.codigo} == ${p.codigo}''';
    final result = await db.rawDelete(sql);
  }

  static Future<void> updatePedido(Pedido p) async{
    final sql = '''UPDATE ${DatabaseCreator.tabelaPedidos} SET 
    ${DatabaseCreator.nome} = "${p.nome}",
    ${DatabaseCreator.cidade} = "${p.cidade}",
    ${DatabaseCreator.valor} = ${p.valor},
    ${DatabaseCreator.data} = "${p.data}",
    ${DatabaseCreator.data} = "${p.data}",
    WHERE ${DatabaseCreator.codigo} = ${p.codigo}
    ''';

    final result = await db.rawUpdate(sql);
  }

  static Future<int> contPedidos() async{
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaPedidos}''');

    int count = data[0].values.elementAt(0);
    return count;
  }
}