import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/model/produto.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaSelecionaItem extends StatefulWidget {
  final List<Produto> produtos;
  final int idVenda;

  const TelaSelecionaItem({Key key, this.produtos, this.idVenda}) : super(key: key);
  @override
  _TelaSelecionaItemState createState() => _TelaSelecionaItemState();
}

class _TelaSelecionaItemState extends State<TelaSelecionaItem> {
  //lista de produtos
  List<Produto> produtos;
  final Color blue = Color(0xFF3C5A99);
  final _controllerPesquisa = TextEditingController();
  int cont;
  int idVenda;

  //quantidade do produto
  int qtd;

  //formato de valores
  final formatoValores = new NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    produtos = widget.produtos;
    idVenda = widget.idVenda;
    cont = produtos.length;
    qtd = 1;
  }


  @override
  Widget build(BuildContext context) {
    //Inicialização do processo
    if (produtos == null) {
      produtos = List<Produto>();
      cont = produtos.length;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Produtos Disponíveis"),
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

  //Buscando os produtos
  _buscaproduto(value) async {
    RepositoryServiceProdutos.buscaProdutos(value).then((lista) {
      setState(() {
        produtos = lista;
        cont = lista.length;
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
            _defineUnidadeProduto(produtos[index]);
          },
          child: Stack(
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //nome e o código
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text("#${produtos[index].idProduto} - ${produtos[index].produtoDescricao}",
                        style: TextStyle(fontSize: 20, color: blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Preço e estoque
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text("${formatoValores.format(produtos[index].pvenda)}", style: TextStyle(fontSize: 19, color: blue, fontWeight: FontWeight.bold),),
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

  _confirmProdutoSelecionado(Produto produto){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Deseja confirmar o produto?", style: TextStyle(fontSize: 25.0),),
                  Divider( height: 20.0, color: Colors.transparent,),
                  Text("Descrição: ${produto.produtoDescricao}"),
                  Divider( height: 5.0, color: Colors.transparent,),
                  Text("Valor: ${formatoValores.format(produto.pvenda)}"),
                  Divider( height: 5.0, color: Colors.transparent,),
                  Text("Quantidade: $qtd"),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              padding: EdgeInsets.all(10.0),
              child: new Text("Cancelar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              padding: EdgeInsets.all(10.0),
              child: new Text("Confirmar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onPressed: () {
                _selecionaProduto(produto);
              },
            ),
          ],
        );
      },
    );
  }

  void _selecionaProduto(Produto produto) async{
    //buscando os dados do usuário do aplicativo
    Usuario usuario;
    //Buscando os dados do usuário do sistema
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('usuario');
    if(data != null){
      usuario = Usuario.fromJson(data);
    }
    //adicionando o produto no banco de itens
    RepositoryServiceVendas.addItenVenda(produto, idVenda, qtd, usuario).then((result){
      print("Item adicionado!");
      Navigator.pop(context);
      Navigator.pop(context);
    });

  }

  void _defineUnidadeProduto(Produto produto) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Informe a quantidade", style: TextStyle(fontSize: 25.0),),
                  Divider( height: 20.0, color: Colors.transparent,),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
                    initialValue: "1",
                    onChanged: (valor){
                      setState(() {
                        qtd = int.parse( valor );
                      });
                    },
                    style:
                    new TextStyle(color: Colors.blueAccent, fontSize: 20),
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(),
                        ),
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              padding: EdgeInsets.all(10.0),
              child: new Text("Confirmar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pop(context);
                _confirmProdutoSelecionado(produto);
              },
            ),
          ],
        );
      },
    );
  }
}
