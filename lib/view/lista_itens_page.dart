import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:intl/intl.dart';

class TelaItensPedido extends StatefulWidget {
  final List<Iten> itens;

  const TelaItensPedido({Key key, this.itens}) : super(key: key);

  @override
  _TelaItensPedidoState createState() => _TelaItensPedidoState();
}

class _TelaItensPedidoState extends State<TelaItensPedido> {

  List<Iten> itens;
  //formato de valores
  final formatoValores = new NumberFormat.currency(locale: "pt_BR", symbol: "R\$");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itens = widget.itens;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens do Pedido"),
        backgroundColor: Color(0xFF3C5A99),
      ),
      body: _criaListaItens(),
    );
  }

  /*Criando a lista dos itens*/
  _criaListaItens(){
    if(itens == null){
      return Center(
        child: Text("Sem Itens", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
      );
    }else{
      return ListView.builder(
        itemCount: widget.itens.length,
        itemBuilder: (context, index){
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
                    width: (MediaQuery.of(context).size.width * 0.95),
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
                              "${widget.itens[index].idProduto}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.itens[index].refFabrica}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //Nome do cliente
                        Text(widget.itens[index].produtoDescricao,
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
                              "${widget.itens[index].qtdVenda}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "  X  ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ ${formatoValores.format(itens[index].pvenda)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ ${formatoValores.format((widget.itens[index].pvenda * widget.itens[index].qtdVenda))}",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
