import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:intl/intl.dart';

import 'detalhe_financeir_page.dart';

class Financeiro extends StatefulWidget {
  final Cliente c;
  final int atraso;
  final double totalAtraso;
  final int vencer;
  final double totalAvencer;
  final int media;

  const Financeiro({Key key, this.c, this.atraso, this.totalAtraso, this.vencer, this.totalAvencer, this.media}) : super(key: key);
  @override
  _FinanceiroState createState() => _FinanceiroState();
}

class _FinanceiroState extends State<Financeiro> {
  final Color blue = Color(0xFF3C5A99);
  NumberFormat formatter = NumberFormat("00.00");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financeiro"),
        backgroundColor: blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            //Primeiro Container com as informações do usuário (codigo e CPF/CNPJ)
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Razão Social",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: blue),
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
                          Text("Nome"),
                          Text(
                            "${widget.c.nomeRazao}",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                          Text("CPF/CNPJ"),
                          Text(
                            "${widget.c.cpfCnpj}",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),

            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),

            //Títulos em atraso
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Títulos em Atraso",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: blue),
                    ),
                    //
                    Table(
                      children: [
                        TableRow(
                            decoration: BoxDecoration(border: Border.all()),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Quantidade"),
                                    Text(
                                      "${widget.atraso}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Atraso Médio"),
                                    Text(
                                      "${widget.media} dias",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                    //
                    Table(
                      children: [
                        TableRow(
                            decoration: BoxDecoration(border: Border.all()),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Valor Total"),
                                    Text(
                                      "R\$ ${formatter.format(widget.totalAtraso)}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                  ],
                )),

            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),

            //Títulos a vencer
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Títulos a Vencer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: blue),
                    ),
                    //
                    Table(
                      children: [
                        TableRow(
                            decoration: BoxDecoration(border: Border.all()),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Quantidade"),
                                    Text(
                                      "${widget.totalAvencer}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Valor Total"),
                                    Text(
                                      "R\$ ${formatter.format(widget.totalAvencer)}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                  ],
                )),

            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),

            //Crédito
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Crédito",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: blue),
                    ),
                    //
                    Table(
                      children: [
                        TableRow(
                            decoration: BoxDecoration(border: Border.all()),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Limite de Crédio"),
                                    Text(
                                      "R\$ ${ (widget.c.limiteCredito == null)? 0 : formatter.format(widget.c.limiteCredito)}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Limite Disponível"),
                                    Text(
                                      "R\$ ${widget.c.limiteDisponivel}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                  ],
                )),

            Divider(
              height: 50,
              color: Colors.transparent,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    height: 60.0,
                    child: RaisedButton(
                        onPressed: () =>
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetalheFinanceiro(c : widget.c)),),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.content_paste,
                                size: 50.0,
                              ),
                              Text(
                                "Detalhamento",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        color: Color.fromARGB(210, 234, 188, 53)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
