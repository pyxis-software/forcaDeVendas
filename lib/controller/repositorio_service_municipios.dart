import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryServiceMunicipios{
  static DatabaseCreator database = DatabaseCreator();

  static Future<List<Municipio>> getAllMunicipos() async{

    Database db = await database.database;
    List<Municipio> municipios = List();

    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaMunicipios}''';
    final data = await db.rawQuery(sql);
    for(final node in data){
      final municipio = Municipio.fromJson(node);
      municipios.add(municipio);
    }
    return municipios;
  }

  static Future<Municipio> getMunicipio(int codigo) async{
    Database db = await database.database;
    Municipio municipio;
    final sql = '''SELECT * FROM ${DatabaseCreator.tabelaMunicipios}
    WHERE ${DatabaseCreator.municipioId} == $codigo''';
    final data = await db.rawQuery(sql);
    data.map((m){
      municipio = Municipio.fromJson(m);
    });
    return municipio;
  }

  static Future<int> addMunicipio(Municipio m) async {
    Database db = await database.database;

    var res = await db.insert(DatabaseCreator.tabelaMunicipios, m.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
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

  static contMunicipios() async{
    Database db = await database.database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.tabelaMunicipios}''');
    int count = data[0].values.elementAt(0);
    return count;
  }
}