import 'dart:math';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_pagamentos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/model/venda.dart';
import 'package:forca_de_vendas/view/adiciona_venda.dart';
import 'package:forca_de_vendas/view/edita_venda.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaPedidos extends StatefulWidget {
  @override
  _TelaPedidosState createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {
  final Color blue = Color(0xFF3C5A99);
  final Color amarelo = Color.fromARGB(210, 234, 188, 53);
  final Color blueSelected = Colors.blue;
  int cont;
  List<Venda> vendas;
  bool selected;
  var randomizer = new Random();
  Usuario usuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cont = 0;
    selected = true;
    _getDadosUsuario();
    _buscaVendas();
  }

  @override
  Widget build(BuildContext context) {
    if (vendas == null) {
      vendas = List<Venda>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        backgroundColor: blue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            //Botão
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: blue,
                ),
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        Text(
                          "Novo Pedido",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () {
                      int id = randomizer.nextInt(10000);
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(now);
                      print(id);
                      //criando uma nova venda
                      Map<String, dynamic> v() => {
                            "id": id,
                            "data_venda": formattedDate,
                            "id_empresa": usuario.empresaId,
                            "id_cliente": 0,
                            "nome_razao": "",
                            "clienteCidade": "",
                            "id_vendedor": usuario.colaboradorId,
                            "id_fpagto": 0,
                            "id_usuario": usuario.usuarioId,
                            "tot_bruto": 0.0,
                            "pedido_status": 0,
                            "tot_desc_prc": 0,
                            "tot_desc_vlr": 0.0,
                            "tot_liquido": 0.0,
                            "pedido_nfiscal": "",
                            "pedido_nfiscal_emissao": ""
                          };
                      //criando a venda
                      Venda venda = Venda.fromMap(v());
                      RepositoryServiceVendas.addVenda(venda).then((idRetorno) {
                        if (idRetorno != null) {
                          RepositoryServicePagamentos.getAllFormasPagamentos()
                              .then((data) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaAdicionaVenda(
                                    pagamentos: data,
                                    vendaId: id,
                                  ),
                                ));
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
            ),

            //Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width / 2.01),
                  child: FlatButton(
                    color: (selected) ? blueSelected : blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Em Aberto",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () {
                      _actionMenu(false);
                    },
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 2.01),
                  child: FlatButton(
                    color: (selected) ? blue : blueSelected,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Faturado",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    onPressed: () {
                      _actionMenu(true);
                    },
                  ),
                ),
              ],
            ),

            //Lista de Pedidos
            Expanded(
              child: _criaLista(),
            ),
          ],
        ),
      ),
    );
  }

  _buscaVendas() {
    RepositoryServiceVendas.getVendasEmAberto().then((data) {
      setState(() {
        vendas = data;
        cont = data.length;
        print(cont);
      });
    });
  }

  _actionMenu(fatura) {
    setState(() {
      selected = (fatura) ? false : true;
    });

    if (fatura) {
      //busca as vendas faturada
      RepositoryServiceVendas.getVendasFaturado().then((data) {
        setState(() {
          vendas = data;
          cont = data.length;
        });
      });
    } else {
      RepositoryServiceVendas.getVendasEmAberto().then((data) {
        setState(() {
          vendas = data;
          cont = data.length;
        });
      });
    }
  }

  _criaLista() {
    return ListView.builder(
      itemCount: cont,
      itemBuilder: (context, index) {
        print(vendas[index].nomeRazao);
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
                  width: (MediaQuery.of(context).size.width / 1.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${vendas[index].id}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${(vendas[index].clienteCidade == "") ? "Sem Cidade" : vendas[index].clienteCidade}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Nome do cliente
                      Text(
                          (vendas[index].nomeRazao == "")
                              ? "Cliente não selecionado ainda"
                              : vendas[index].nomeRazao,
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
                            vendas[index].dataVenda,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "R\$ ${vendas[index].totLiquido.toStringAsPrecision(4)}",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 17),
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
                        child: Icon(
                          Icons.edit,
                          size: 50,
                          color: amarelo,
                        ),
                        onPressed: () {
                          //editando o pedido
                          RepositoryServicePagamentos.getAllFormasPagamentos().then((data) {
                            RepositoryServicePagamentos.getFormaPagamento(vendas[index].idFpagto).then((forma){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TelaEditaVenda(
                                    pagamentos: data,
                                    fp: forma,
                                  venda: vendas[index],
                                ),
                              ));
                            });
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        onPressed: () {
                          _showConfirmDelete(vendas[index]);
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
    );
  }

  Cliente _getDadosCliente(id) {
    RepositoryServiceCliente.getCliente(id).then((cliente) {
      return cliente;
    });
  }

  _getDadosUsuario() async {
    //Buscando os dados do usuário do sistema
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('usuario');
    if (data != null) {
      setState(() {
        usuario = Usuario.fromJson(data);
      });
    } else {
      return Navigator.pushNamedAndRemoveUntil(
          context, "/configuracao", (r) => false);
    }
  }

  //Show confirm delete
  _showConfirmDelete(venda) {
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
                "Deseja mesmo excluir a venda?",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                _removeVenda(venda);
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

  void _removeVenda(venda) {
    //removenda a venda completa
    RepositoryServiceVendas.removeItens(venda).then((response){
      //excluindo a venda
      RepositoryServiceVendas.removeVenda(venda).then((responseVenda){
        _buscaVendas();
        Navigator.pop(context);
      });
    });
  }
}
