import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_pagamentos.dart';
import 'package:forca_de_vendas/model/venda.dart';
import 'package:forca_de_vendas/view/seelciona_cliente_venda_page.dart';
import 'package:forca_de_vendas/view/seleciona_cliente_edita.dart';

import 'altera_informacoes_page.dart';
import 'altera_itens_page.dart';

class TelaEdita extends StatefulWidget {
  final Venda venda;

  const TelaEdita({Key key, this.venda}) : super(key: key);

  @override
  _TelaEditaState createState() => _TelaEditaState();
}

class _TelaEditaState extends State<TelaEdita> {
  final Color blue = Color(0xFF3C5A99);

  //Venda
  Venda venda;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    venda = widget.venda;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Venda"),
        backgroundColor: blue,
      ),
      backgroundColor: blue,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.30,
              left: 20,
              right: 20),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      "Editar Itens",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlteraItensPedido(
                        vendaId: venda.id,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      "Alterar Cliente",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaSelecionaClienteVendaEdita(
                        idVenda: venda.id,
                      ),
                    ),
                  );
                },
              ),
              /*
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      "Editar outras informações",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: (){
                  RepositoryServicePagamentos.getAllFormasPagamentos().then((listaPagamentos){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlteraInfoPedido(
                          formasPagamento: listaPagamentos,
                          venda: venda
                        ),
                      ),
                    );
                  });
                },
              )
               */
            ],
          ),
        ),
      ),
    );
  }
}
