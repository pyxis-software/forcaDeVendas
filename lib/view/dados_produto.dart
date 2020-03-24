import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/produto.dart';

class DadosProduto extends StatefulWidget {
  final Produto produto;

  const DadosProduto({Key key, this.produto}) : super(key: key);

  @override
  _DadosProdutoState createState() => _DadosProdutoState();
}

class _DadosProdutoState extends State<DadosProduto> {
  final Color blue = Color(0xFF3C5A99);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: blue,
         title: Text("Dados do Produto"),
       ),
       body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child:  Column(
              children: <Widget>[
                //Primeiro Container com as informações do usuário (codigo e CPF/CNPJ)
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.4,
                        height: (MediaQuery.of(context).size.height) * 0.2,
                        child: Text(""),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.55,
                        height: (MediaQuery.of(context).size.height) * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: (MediaQuery.of(context).size.width) * 0.55,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Código"),
                                  Text("${widget.produto.idProduto}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: (MediaQuery.of(context).size.width) * 0.55,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Referência"),
                                  Text("${widget.produto.refFabrica}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(210, 234, 188, 53),
                    border: Border.all(),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Descrição"),
                      Text("${widget.produto.produtoDescricao}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                    ],
                  ),
                ),
                Divider(height: 10.0,),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Fabricante"),
                      Text("${widget.produto.fabricanteNome}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                    ],
                  ),
                ),

                Table(
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Grupo"),
                              Text("${widget.produto.grupoNome}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Subgrupo"),
                              Text("${widget.produto.subgrupoNome}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                      ]
                    )
                  ],
                ),

                Table(
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("GTIN"),
                              Text("${widget.produto.gtin}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("NCM"),
                              Text("${widget.produto.idNcm}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                      ]
                    )
                  ],
                ),

                Divider(height: 10.0,),

                Table(
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(210, 234, 188, 53),
                        border: Border.all()
                      ),
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Quantidade Estoque"),
                              Text("${widget.produto.saldoGeral}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Preço Unitário"),
                              Text("${widget.produto.pvenda}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                        ),
                      ]
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}