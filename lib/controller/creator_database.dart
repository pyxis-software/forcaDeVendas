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
  static const clienteId = "id";
  static const clientetpPessoa = "tp_pessoa";
  static const clienteCpf = "cpf_cnpj";
  static const clienteNomeRazao = "nome_razao";
  static const clienteApelido = "apelido_fantasia";
  static const clienteRgInsc = "rg_insc";
  static const clienteInscMunicipal = "insc_municipal";
  static const clienteFone1 = "fone1";
  static const clienteFone2 = "fone2";
  static const clienteFone3 = "fone3";
  static const clienteCEP = "cep";
  static const clienteEndereco = "endereco";
  static const clienteEnderecoNumero = "endereco_numero";
  static const clienteComplemento = "complemento";
  static const clienteBairro = "bairro";
  static const clienteIdMunicipio = "id_municipio";
  static const clienteIdStatus = "id_status";
  static const clienteIdClienteTipo = "id_cliente_tipo";

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

  //Tabela municipios
  static const tabelaMunicipios = "municipios";
  static const municipioId = "id_municipio";
  static const municipioNome = "municipio_nome";
  static const municipioEstado = "municipio_estado";
  static const municipioPaisNome = "pais_nome";
  static const municipioidPessoa = "id_pessoa";

  //tabela de formas de pagamentos
  static const tabelaPagamentos = "formas_pagtos";
  static const pagamentoId = "id";
  static const pagamentoDescricao = "descricao";
  static const pagamentoQtdParcelas = "qtdade_parc";
  static const pagamentoStatus = "status";

  //tabela tipo clientes
  static const tabelaTipoClientes = "clientes_tipos";
  static const clienteTipoId = "id";
  static const clienteTipoDesc = "descricao";
  static const clienteTipoStatus = "status";

  //tabela clientes status
  static const tabelaClientesStatus = "clientes_status";
  static const tabelaClientesStatusId = "id";
  static const tabelaClientesStatusDescricao = "descricao";
  static const tabelaClientesStatusBloqueiaPessoa = "bloque_pessoa";




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
      $clienteId INTEGER PRIMARY KEY,
      $clientetpPessoa INTEGER,
      $clienteCpf TEXT,
      $clienteNomeRazao TEXT,
      $clienteApelido TEXT,
      $clienteRgInsc TEXT,
      $clienteInscMunicipal INTEGER,
      $clienteFone1 TEXT,
      $clienteFone2 TEXT,
      $clienteFone3 TEXT,
      $clienteCEP TEXT,
      $clienteEndereco TEXT,
      $clienteEnderecoNumero TEXT,
      $clienteComplemento TEXT,
      $clienteBairro TEXT,
      $clienteIdMunicipio INTEGER,
      $clienteIdStatus INTEGER,
      $clienteIdClienteTipo INTEGER,
      UNIQUE($clienteId)
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

    //Criando a tabela de municipios
    final municipiosSql = '''CREATE TABLE $tabelaMunicipios
    (
      $municipioidPessoa INTEGER,
      $municipioId INTEGER PRIMARY KEY,
      $municipioNome TEXT,
      $municipioEstado TEXT,
      $municipioPaisNome TEXT,
      UNIQUE($municipioidPessoa)
    )
    ''';

    //Criando a tebela de formas de pagamento
    final pagamentosSql = '''CREATE TABLE $tabelaPagamentos
    (
      $pagamentoId INTEGER PRIMARY KEY,
      $pagamentoDescricao TEXT,
      $pagamentoQtdParcelas INTEGER,
      $pagamentoStatus INTEGER,
      UNIQUE($pagamentoId)
    )
    ''';

    //Criando a tabela de tipos de clientes
    final tipoClienteSql = '''CREATE TABLE $tabelaTipoClientes
    (
      $clienteTipoId INTEGER PRIMARY KEY,
      $clienteTipoDesc TEXT,
      $clienteTipoStatus INTEGER,
      UNIQUE($clienteTipoId)
    )
    ''';

    //Criando a tabela de status de cliente
    final clienteStatusSql = '''CREATE TABLE $tabelaClientesStatus
    (
      $tabelaClientesStatusId INTEGER PRIMARY KEY,
      $tabelaClientesStatusDescricao TEXT,
      $tabelaClientesStatusBloqueiaPessoa INTEGER,
      UNIQUE($tabelaClientesStatusId)
    )
    ''';


    await db.execute(todoSql);
    await db.execute(clienteSql);
    await db.execute(produtosSql);
    await db.execute(municipiosSql);
    await db.execute(pagamentosSql);
    await db.execute(tipoClienteSql);
    await db.execute(clienteStatusSql);
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