import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/forma_pagamento.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:forca_de_vendas/model/venda.dart';
import 'package:forca_de_vendas/view/seelciona_cliente_venda.dart';
import 'package:forca_de_vendas/view/seleciona_item_pedido.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaEditaVenda extends StatefulWidget {
  final List<FormaPagamento> pagamentos;
  final FormaPagamento fp;
  final Venda venda;
  const TelaEditaVenda({Key key, this.pagamentos, this.fp, this.venda})
      : super(key: key);
  @override
  _TelaAdicionaVendaState createState() => _TelaAdicionaVendaState();
}

class _TelaAdicionaVendaState extends State<TelaEditaVenda> {
  final Color blue = Color(0xFF3C5A99);
  final Color amarelo = Color.fromARGB(210, 234, 188, 53);
  bool clienteSelected;
  int contItens;
  int idCliente;
  Cliente clienteSelecionado;
  Timer t;

  //Lista de itens do pedido
  List<Iten> itens;
  List<FormaPagamento> formasPagamento;
  FormaPagamento formaPagamento;

  //Id Da venda
  Venda venda;
  int vendaId;
  //tipo de desconto (0 - %, 1 - dinheiro)
  int tipoDesconto;
  //desconto
  int desconto;
  //total vendas
  double totalVendas;
  //total com desconto
  double totalBruto;

  //Input do valor de desconto
  final inputDesconto = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    venda = widget.venda;
    clienteSelected = false;
    contItens = 0;
    idCliente = 0;
    formasPagamento = widget.pagamentos;
    formaPagamento = formasPagamento[0];
    tipoDesconto = -1;
    desconto = 0;
    totalVendas = 0;
    totalBruto = 0;
    vendaId = venda.id;
    _initVerificacaoDados();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (itens == null) {
      itens = List<Iten>();
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Novo Pedido"),
        backgroundColor: blue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              //Nome do cliente
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _telaNomeCliente(),
                  Container(
                    color: amarelo,
                    padding: EdgeInsets.all(10.0),
                    width: (MediaQuery.of(context).size.width / 6),
                    child: FlatButton(
                      child: Icon(
                        Icons.person_add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaSelecionaClienteVenda(),
                            ));
                      },
                    ),
                  ),
                ],
              ),

              //Lista de itens
              SizedBox(
                height: 20,
              ),
              Text(
                "Ítens do Pedido",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              _criaListaItens(),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5.0),
                  color: amarelo,
                  child: ListView(
                    children: <Widget>[
                      Text(
                        "Formas de Pagamento",
                        textDirection: TextDirection.ltr,
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),

                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: DropdownButton(
                          isExpanded: true,
                          value: formaPagamento,
                          items: formasPagamento.map((FormaPagamento fp) {
                            return DropdownMenuItem<FormaPagamento>(
                              value: fp,
                              child: Text(
                                fp.descricao,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            );
                          }).toList(),
                          onChanged: (fp) {
                            setState(() {
                              formaPagamento = fp;
                            });
                            //altera a forma de pagamento da venda
                            RepositoryServiceVendas.alteraFormaPagamento(
                                formaPagamento.id, vendaId);
                          },
                        ),
                      ),

                      //Total dos itens
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Valor dos Produtos"),
                            Text(
                              "R\$ ${totalVendas.toStringAsPrecision(4)}",
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      //Descontos
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Tipo de Desconto",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                "Selecione",
                                style: TextStyle(fontSize: 17.0),
                              ),
                              value: tipoDesconto,
                              items: [
                                DropdownMenuItem(
                                  value: -1,
                                  child: Text(
                                    "SELECIONE",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "PORCENTAGEM${(desconto == 0) ? "" : " - $desconto %"}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "VALOR${(desconto == 0) ? "" : " - R\$ $desconto"}",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ),
                              ],
                              onChanged: (tp) {
                                if (tp != -1) {
                                  setState(() {
                                    tipoDesconto = tp;
                                  });
                                  _exibeInputDesconto();
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      //Total Bruto
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Valor Total"),
                            Text(
                              "R\$ ${totalBruto.toStringAsPrecision(4)}",
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      //Adicionar Item
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: GestureDetector(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add),
                              Text(
                                "Adicionar Item",
                                style: TextStyle(
                                    fontSize: 19.0, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          onTap: (){
                            RepositoryServiceProdutos.getAllProdutos()
                                .then((data) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaSelecionaItem(
                                      produtos: data,
                                      idVenda: vendaId,
                                    ),
                                  ));
                            });
                          },
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

  _telaNomeCliente() {
    //buscando o id do cliente
    if (clienteSelected) {
      return Container(
        padding: EdgeInsets.all(10.0),
        color: amarelo,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width / 4),
                  child: Text("Código"),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 2),
                  child: Text("Nome"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width / 4),
                  child: Text(
                    "${clienteSelecionado.id}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 2),
                  child: Text("${clienteSelecionado.nomeRazao}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0)),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 60,
        width: (MediaQuery.of(context).size.width / 1.3),
        padding: EdgeInsets.all(10.0),
        color: amarelo,
        alignment: Alignment.center,
        child: Text(
          "Selecione o cliente",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
  }

  //Buscando os itens do pedido
  _getIItensPedido() {
    print("Buscando os itens");
    RepositoryServiceVendas.getItensVenda(vendaId).then((lista) {
      //salvando o valor total
      double soma = 0.0;
      for (Iten i in lista) {
        final totalProduto = (i.pvenda * i.qtdVenda);
        soma += totalProduto;
      }
      print("Soma: $soma");
      setState(() {
        totalVendas = soma;
        itens = lista;
        contItens = lista.length;
      });
      //
    });
  }

  _criaListaItens() {
    return Container(
      height: (MediaQuery.of(context).size.height / 3.5),
      child: ListView.builder(
        itemCount: contItens,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Container das informações do cliente e do pedido
                  Container(
                    padding: EdgeInsets.all(5.0),
                    width: (MediaQuery.of(context).size.width / 1.4),
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
                              "R\$ ${itens[index].pvenda.toStringAsPrecision(4)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ ${(itens[index].pvenda * itens[index].qtdVenda).toStringAsPrecision(4)}",
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
                    width: (MediaQuery.of(context).size.width / 5),
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _showConfirmDeleteItenPedido(itens[index]);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 50,
                            color: amarelo,
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

  _verificaIdCliente() async {
    print("Verificando");
    _getIItensPedido();

    RepositoryServiceCliente.getCliente(venda.idCliente).then((data) {
      setState(() {
        clienteSelecionado = data;
        clienteSelected = true;
      });
    });
  }

  //inicia a verificacao
  _initVerificacaoDados() {
    t = Timer.periodic(new Duration(seconds: 3), (timer) {
      _verificaIdCliente();

      //calculando os descontos
      //verifica se o desconto é em porcentagem
      double des = 0;
      if (tipoDesconto == 0) {
        des = (totalVendas * desconto) / 100;
        setState(() {
          totalBruto = totalVendas - des;
        });
      } else if (tipoDesconto == 1) {
        des = desconto.toDouble();
        setState(() {
          totalBruto = totalVendas - desconto;
        });
      } else {
        print("Desconto não foi selecionado");
        setState(() {
          totalBruto = totalVendas;
        });
      }

      //atualiza o valor no bando de dados
      RepositoryServiceVendas.alteraValorVenda(
              totalVendas, totalBruto, des, vendaId)
          .then((result) {
        print("Valor da venda alterado!");
      });
    });
  }

  //Exibe o input do valor do desconto
  _exibeInputDesconto() {
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
              Text(
                "Informe ${(tipoDesconto == 0) ? "a porcentagem" : "o valor"} do desconto",
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              TextFormField(
                controller: inputDesconto,
                keyboardType: TextInputType.number,
                onChanged: (text) {},
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Salvar"),
              onPressed: () {
                setState(() {
                  desconto = int.parse(inputDesconto.text);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showConfirmDeleteItenPedido(Iten iten){
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
                  Text("Atenção!", style: TextStyle(fontSize: 20),),
                  Divider( height: 20.0, color: Colors.transparent,),
                  Text("Excluir ítem do pedido?", style: TextStyle(fontSize: 18),),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirmar"),
              onPressed: () {
                RepositoryServiceVendas.removeIten(iten).then((data){
                  Navigator.pop(context);
                });
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
