import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/model/produto.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

import 'dados_produto_page.dart';

class TelaProdutos extends StatefulWidget {
  @override
  _TelaProdutosState createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  //Minhas alterações'
  final Color blue = Color(0xFF3C5A99);
  final _controllerPesquisa = TextEditingController();
  String host;
  ProgressDialog load;
  int cont = 0;
  List<Produto> produtos;
  DatabaseCreator database = DatabaseCreator();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Inicialização do processo
    if (produtos == null) {
      produtos = List<Produto>();
      _getProdutos();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        backgroundColor: blue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            //Tela do campo de busca e botão
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Código, Descrição ou Referência"),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      controller: _controllerPesquisa,
                      onChanged: (value) {
                        _buscaproduto(value);
                      },
                      keyboardType: TextInputType.text,
                      style:
                          new TextStyle(color: Colors.blueAccent, fontSize: 20),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                          ),
                          labelStyle: TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              ),
            ),

            //Criando a tabela de amostra
            /*
            Container(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.2),
                    1: FractionColumnWidth(.3),
                    2: FractionColumnWidth(.1),
                    3: FractionColumnWidth(.2),
                    4: FractionColumnWidth(.2)
                  },
                  children: [
                    _criarLinhaTable("Código,Descrição,Un,Preço,Estoque"),
                  ],
                ),
              ),
            ),
             */

            //mostra os produtos disponíves
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height / 1),
                child: _criaLista(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Buscando o Host da API
  void buscaHost() async {
    final pref = await SharedPreferences.getInstance();
    String h = pref.getString('host');
    String id = pref.getString('id_vend');
    if (h != null && id != null) {
      setState(() {
        host = h;
      });
    }
  }

  //Buscando os produtos via API
  _getProdutos() async {
    final Future<Database> dbFuture = database.initDatabase();
    dbFuture.then((data) {
      Future<List<Produto>> produtoFuture =
          RepositoryServiceProdutos.getAllProdutos();
      produtoFuture.then((lista) {
        setState(() {
          produtos = lista;
          cont = lista.length;
        });
      });
    });
  }

  //Buscando os produtos
  _buscaproduto(value) async {
    final Future<Database> dbFuture = database.initDatabase();
    dbFuture.then((data) {
      Future<List<Produto>> produtoFuture =
          RepositoryServiceProdutos.buscaProdutos(value);
      produtoFuture.then((lista) {
        setState(() {
          produtos = lista;
          cont = lista.length;
        });
      });
    });
  }

  //Cria a lista dos produtos
  _criaLista() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
        height: 20,
      ),
      shrinkWrap: true,
      itemCount: cont,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DadosProduto(
                    produto: produtos[index],
                  ),
                ));
          },
          child: Stack(
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //nome e o código
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text("#${produtos[index].idProduto} - ${produtos[index].produtoDescricao}",
                        style: TextStyle(fontSize: 20, color: blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Preço e estoque
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text("R\$ ${produtos[index].pvenda.toStringAsPrecision(4)}", style: TextStyle(fontSize: 19, color: blue, fontWeight: FontWeight.bold),),
                          ),
                          Container(
                            child: Text("${produtos[index].produtoUnidade}"),
                          ),
                          Container(
                            child: Text("${produtos[index].saldoGeral.toInt()} em Estoque"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //Cria a tabela de rotulos
  _criarLinhaTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            backgroundBlendMode: BlendMode.difference,
          ),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontSize: 16.0),
          ),
          padding: EdgeInsets.all(5.0),
        );
      }).toList(),
    );
  }
}
