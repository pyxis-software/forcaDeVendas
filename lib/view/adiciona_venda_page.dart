import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:forca_de_vendas/view/seelciona_cliente_venda_page.dart';
import 'package:forca_de_vendas/view/seleciona_item_pedido_page.dart';

class TelaAdicionaVenda extends StatefulWidget {
  final int vendaId;

  const TelaAdicionaVenda({this.vendaId, Key key}) : super(key: key);

  @override
  _TelaAdicionaVendaState createState() => _TelaAdicionaVendaState();
}

class _TelaAdicionaVendaState extends State<TelaAdicionaVenda> {
  final Color blue = Color(0xFF3C5A99);
  final Color amarelo = Color.fromARGB(210, 234, 188, 53);
  Timer t;

  //Lista de itens do pedido
  List<Iten> itens;

  //Id Da venda
  int vendaId;
  int contItens;
  double soma;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contItens = 0;
    vendaId = widget.vendaId;
    soma = 0.0;
    _initVerificacaoDados();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              content: Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Deseja mesmo cancelar o pedido?",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Cancelar Pedido"),
                  onPressed: () {
                    RepositoryServiceVendas.removeVenda(vendaId);
                    Navigator.pop(context);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> _onBack() {
    false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (contItens == 0) ? _onBackPressed : _onBack(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Novo Pedido"),
          backgroundColor: blue,
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.70,
                child: Container(
                  color: blue,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Text((contItens != 0) ? "R\$ ${soma.toStringAsPrecision(4)}" : "Adicione os Itens primeiro!", style: TextStyle(fontSize: 20, color: Colors.white),),
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      _criaListaItens(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          //buscando a lista de produtos disponíveis
                          RepositoryServiceProdutos.getAllProdutos().then((lista){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => TelaSelecionaItem(produtos: lista, idVenda: vendaId,)));
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Adicionar Item",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Visibility(
                        visible: (contItens != 0) ? true : false,
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => TelaSelecionaClienteVenda(idVenda: vendaId,)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "Adicionar Cliente",
                                    style:
                                    TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Buscando os itens do pedido
  _getIItensPedido() {
    print("Buscando os itens");
    RepositoryServiceVendas.getItensVenda(vendaId).then((lista) {
      //salvando o valor total
      double s = 0.0;
      for (Iten i in lista) {
        final totalProduto = (i.pvenda * i.qtdVenda);
        s += totalProduto;
      }
      setState(() {
        contItens = lista.length;
        itens = lista;
        soma = s;
      });
    });
  }

  _criaListaItens() {
    if(contItens == 0){
      return Center(
        child: Text("Sem Itens", style: TextStyle(fontSize: 25, color: Colors.white),),
      );
    }else {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.60,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: contItens,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Container das informações do cliente e do pedido
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width / 1.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Código",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Referência",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${itens[index].idProduto}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${itens[index].refFabrica}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //Nome do cliente
                          Text(itens[index].produtoDescricao,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),

                          SizedBox(
                            height: 10,
                          ),
                          //data e valor
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${itens[index].qtdVenda}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "  X  ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "R\$ ${itens[index].pvenda.toStringAsPrecision(
                                    4)}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "R\$ ${(itens[index].pvenda *
                                    itens[index].qtdVenda).toStringAsPrecision(
                                    4)}",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //Container com os botões de ação
                    Container(
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width / 5),
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _showConfirmDeleteItenPedido(itens[index]);
                            },
                            child: Icon(
                              Icons.delete,
                              size: 50,
                              color: blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  //inicia a verificacao
  _initVerificacaoDados() {
    t = Timer.periodic(new Duration(seconds: 2), (timer) {
      _getIItensPedido();
    });
  }

  _showConfirmDeleteItenPedido(Iten iten) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Atenção!",
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Text(
                "Excluir ítem do pedido?",
                style: TextStyle(fontSize: 18),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirmar"),
              onPressed: () {
                RepositoryServiceVendas.removeIten(iten);
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
