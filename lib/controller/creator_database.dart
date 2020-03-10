import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database  db;

class DatabaseCreator {

  //Tabela Pedidos
  static const tabelaPedidos = "pedidos";
  static const id = "id";
  static const nome = "nome";
  static const codigo = "codigo";
  static const cidade = "cidade";
  static const valor = "valor";
  static const data = "data";
  static const isFaturado = "isFaturado";

  //Tabela Clientes
  static const tabelaClientes = "clientes";
  static const clienteCodigo = "codigo";
  static const clienteCPF = "cpf";
  static const clienteNome = "nome";
  static const clienteEndereco = "endereco";
  static const clienteBairro = "bairro";
  static const clienteCidade = "cidade";
  static const clienteEstado = "estado";
  static const clienteCEP = "cep";
  static const clienteTelefone = "telefone";
  static const clienteCelular = "celular";
  

  static void databaseLog(String functionName, String sql,
  [List<Map<String, dynamic>> selectQueryResults, int insertAndUpdateQueryResult]){
    print(functionName);
    print(sql);
    if(selectQueryResults != null){
      print(selectQueryResults);
    }else if (insertAndUpdateQueryResult != null){
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createTodoTable(Database db) async{
    final todoSql = '''CREATE TABLE $tabelaPedidos
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nome TEXT,
      $codigo INTEGER,
      $cidade TEXT,
      $valor INTEGER,
      $data TEXT,
      $isFaturado BIT NOT NULL
    )''';
    final clienteSql = '''CREATE TABLE $tabelaClientes
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $clienteCodigo INTEGER NOT NULL,
      $clienteCPF TEXT,
      $clienteNome TEXT,
      $clienteEndereco TEXT,
      $clienteBairro TEXT,
      $clienteCidade TEXT,
      $clienteEstado TEXT,
      $clienteCEP TEXT,
      $clienteTelefone TEXT,
      $clienteCelular TEXT

    )
    ''';
    await db.execute(todoSql);
    await db.execute(clienteSql);
  }

  Future<String> getDatabasePath (String dbName)async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //verifica se a pasta existe
    if(await Directory(dirname(path)).exists()){
      await deleteDatabase(path);
    }else{
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('forcaVendas');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async{
    await createTodoTable(db);
  }
}