import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseCreator {
  static Database _database;

  //Tabela Pedidos
  static const tabelaVenda = "vendas";
  static const vendasId = "id";
  static const vendaIdEmpresa = "id_empresa";
  static const vendaIdCliente = "id_cliente";
  static const clienteCidade = "clienteCidade";
  static const vendaIdVendedor = "id_vendedor";
  static const vendaIdFormaPagamento = "id_fpagto";
  static const vendaIdUsuario = "id_usuario";
  static const vendaTotalBruto = "tot_bruto";
  static const vendaDescontoParcela = "tot_desc_prc";
  static const vendaDescontoValor = "tot_desc_vlr";
  static const vendaTotalLiquido = "tot_liquido";
  static const vendaData = "data_venda";
  static const vendaStatus = "pedido_status";
  static const vendaNFiscal = "pedido_nfiscal";
  static const vendaNFiscalEmissao = "pedido_nfiscal_emissao";
  static const vendaLat = "lat";
  static const vendaLng = "lng";
  static const vendaTipoDesconto = "tipoDesconto";
  static const vendaDesconto = "desconto";

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
  static const clienteLimiteCredito = "limite_credito";
  static const clienteLimitePendente = "total_pendente";
  static const clienteLimiteDisponivel = "limite_disponivel";
  static const clienteEmail = "email";

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

  //Tabela financeiros
  static const tabelaClientesFinanceiro = "clientes_financeiro";
  static const tabelaClientesFinanceiroId = "id";
  static const tabelaClientesFinanceiroIdCliente = "id_cliente";
  static const tabelaClientesFinanceiroIdvenda = "id_venda";
  static const tabelaClientesFinanceiroDataVenc= "data_vecto";
  static const tabelaClientesFinanceiroValor = "valor_doc";
  static const tabelaClientesFinanceiroNumParcelas = "parc_num";
  static const tabelaClientesFinanceiroQtdParcelas = "parc_qtd";

  //tabela itens do pedido
  static const tabelaItensPedido = "itens_pedido";
  static const tabelaItensPedidoId = "id";
  static const tabelaItensIdVenda = "id_venda";
  static const tabelaItensPedidoItem = "item";
  static const tabelaItensIdProduto = "id_produto";
  static const tabelaItensComplemento = "complemento";
  static const tabelaItensValorVendido = "vlr_vendido";
  static const tabelaItensQtd = "qtd_venda";
  static const tabelaItensTotalBruto = "tot_bruto";
  static const tabelaItensDescontoParcela = "vlr_desc_prc";
  static const tabelaItensDescontoValor = "vlr_desc_vlr";
  static const tabelaItensValorLiquido = "vlr_liquido";
  static const tabelaItensGrade = "grade";
  static const tabelaItensIdVendedor = "id_vendedor";


  //Tabela de agendamentos
  static const tabelaAgendamento = "agendamentos";
  static const tabelaAgendamentoId = "id";
  static const tabelaAgendamentoIdCliente = "id_pessoa";
  static const tabelaAgendamentoNomeCliente = "nome_cliente";
  static const tabelaAgendamentoIdVendador = "id_vendedor";
  static const tabelaAgendamentoData = "data";
  static const tabelaAgendamentoObservacao = "observacao";
  static const tabelaAgendamentoVisitou = "visitou";

  Future<void> createTodoTable(Database db) async{
    final todoSql = '''CREATE TABLE $tabelaVenda
    (
      $vendasId NTEGER PRIMARY KEY,
      $vendaIdEmpresa INTEGER,
      $vendaIdCliente INTEGER,
      $clienteNomeRazao TEXT,
      $clienteCidade TEXT,
      $vendaIdVendedor INTEGER,
      $vendaIdFormaPagamento INTEGER,
      $vendaIdUsuario INTEGER,
      $vendaTotalBruto DOUBLE,
      $vendaDescontoParcela INTEGER,
      $vendaDescontoValor "DOUBLE",
      $vendaData TEXT,
      $vendaTotalLiquido DOUBLE,
      $vendaStatus INTEGER,
      $vendaNFiscal INTEGER,
      $vendaNFiscalEmissao TEXT,
      $vendaLat TEXT,
      $vendaLng TEXT,
      $vendaTipoDesconto INTEGER,
      $vendaDesconto INTEGER,
      UNIQUE($vendasId)
    )''';

    final createtableItens = '''CREATE TABLE $tabelaItensPedido
    (
      $tabelaItensPedidoId NTEGER PRIMARY KEY,
      $produtoIdProduto INTEGER,
      $tabelaItensIdVenda INTEGER,
      $tabelaItensQtd INTEGER,
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
      UNIQUE($tabelaItensPedidoId)
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
      $clienteLimiteCredito INTEGER,
      $clienteLimitePendente DOUBLE,
      $clienteLimiteDisponivel DOUBLE,
      $clienteEmail TEXT,
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

    //Criando a tabela de financeiro do cliente
    final clientesFinanceiro = '''CREATE TABLE $tabelaClientesFinanceiro
    (
      $tabelaClientesFinanceiroId INTEGER PRIMARY KEY,
      $tabelaClientesFinanceiroIdCliente INTEGER,
      $tabelaClientesFinanceiroIdvenda INTEGER,
      $tabelaClientesFinanceiroDataVenc TEXT,
      $tabelaClientesFinanceiroValor REAL,
      $tabelaClientesFinanceiroNumParcelas INTEGER,
      $tabelaClientesFinanceiroQtdParcelas INTEGER,
      UNIQUE($tabelaClientesFinanceiroId)
    )
    ''';


    //Criando a tabela de agendamentos
    final agendamento = '''CREATE TABLE $tabelaAgendamento
    (
      $tabelaAgendamentoId INTEGER PRIMARY KEY,
      $tabelaAgendamentoIdCliente INTEGER,
      $tabelaAgendamentoNomeCliente TEXT,
      $tabelaAgendamentoIdVendador INTEGER,
      $tabelaAgendamentoData TEXT,
      $tabelaAgendamentoObservacao TEXT,
      $tabelaAgendamentoVisitou INTEGER,
      UNIQUE($tabelaAgendamentoId)
    )
    ''';


    await db.execute(todoSql);
    await db.execute(createtableItens);
    await db.execute(clienteSql);
    await db.execute(produtosSql);
    await db.execute(municipiosSql);
    await db.execute(pagamentosSql);
    await db.execute(tipoClienteSql);
    await db.execute(clienteStatusSql);
    await db.execute(clientesFinanceiro);
    await db.execute(agendamento);
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