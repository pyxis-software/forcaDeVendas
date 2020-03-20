import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseCreator {
  static Database _database;



  //Tabela Pedidos
  static const tabelaPedidos = "PEDIDOS";
  static const id = "ID";
  static const nome = "NOME";
  static const codigo = "CODIGO";
  static const cidade = "CIDADE";
  static const valor = "VALOR";
  static const data = "DATA";
  static const isFaturado = "IS_FATURADO";

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

  //Tabela Produtos
  static const tabelaProdutos = "PRODUTOS";
  static const produtoIdEmpresa = "id_empresa";
  static const produtoIdProduto = "id_produto";
  static const produtoDescricao = "produto_descricao";
  static const produtoRefFabrica = "ref_fabrica";
  static const produtoGtin = "gtin";
  static const produtoAplicacao = "aplicacao";
  static const produtoPeso = "peso";
  static const produtoIdFabricante = "id_fabricante";
  static const produtoNomeFabricante = "fabricante_nome";
  static const produtoIdGrupo = "id_grupo";
  static const produtoNomeGrupo = "grupo_nome";
  static const produtoIdSubGrupo = "id_sub_grupo";
  static const produtoSubGrupoNome = "subgrupo_nome";
  static const produtoIdNcm = "id_ncm";
  static const produtoGrade = "grade";
  static const produtoPVenda = "pvenda";
  static const produtoSaldoGeral = "saldo_geral";
  static const produtoUnidade = "produto_unidade";
  

  Future<void> createTodoTable(Database db) async{
    final todoSql = '''CREATE TABLE $tabelaPedidos
    (
      $nome TEXT,
      $codigo INTEGER,
      $cidade TEXT,
      $valor INTEGER PRIMARY KEY,
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

    final produtosSql = '''CREATE TABLE $tabelaProdutos
    (
      $produtoIdProduto INTEGER PRIMARY KEY AUTOINCREMENT,
      $produtoIdEmpresa INTEGER,
      $produtoDescricao TEXT,
      $produtoRefFabrica TEXT,
      $produtoGtin TEXT,
      $produtoAplicacao TEXT,
      $produtoPeso INTEGER,
      $produtoIdFabricante INTEGER,
      $produtoNomeFabricante TEXT,
      $produtoIdGrupo INTEGER,
      $produtoNomeGrupo TEXT,
      $produtoIdSubGrupo INTEGER,
      $produtoSubGrupoNome TEXT,
      $produtoIdNcm TEXT,
      $produtoGrade TEXT,
      $produtoPVenda REAL,
      $produtoSaldoGeral INTEGER,
      $produtoUnidade TEXT,
      UNIQUE($produtoIdProduto)
    )
    ''';
    await db.execute(todoSql);
    await db.execute(clienteSql);
    await db.execute(produtosSql);
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

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'forcaVendas.db';
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int version) async{
    await createTodoTable(db);
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initDatabase();
    }
    return _database;
  }
}