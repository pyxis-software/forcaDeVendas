import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/forma_pagamento.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInformacaoVenda extends StatefulWidget {
  final int idVenda;
  final List<FormaPagamento> formasPagamento;

  const TelaInformacaoVenda({Key key, this.idVenda, this.formasPagamento})
      : super(key: key);

  @override
  _TelaInformacaoVendaState createState() => _TelaInformacaoVendaState();
}

class _TelaInformacaoVendaState extends State<TelaInformacaoVenda> {
  //cor padrao do aplicativo
  final Color blue = Color(0xFF3C5A99);

  //id da venda
  int idVenda;

  //total de itens
  int totalItens;

  //valor dos itens
  double valorItens;

  //Cliente da venda
  Cliente cliente;

  //lista de formas de pagamento
  List<FormaPagamento> formasPagamento;

  //forma de pagamento selecionada
  FormaPagamento FpSelecionada;

  //Controller do campo de desconto
  final controllerDesconto = TextEditingController();
  int tipoDesconto;
  int desconto;
  double valorDesconto;
  double totalDesconto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idVenda = widget.idVenda;
    totalItens = 0;
    totalItens = 0;
    valorDesconto = 0;
    totalDesconto = 0;
    formasPagamento = widget.formasPagamento;
    FpSelecionada = formasPagamento[0];
    tipoDesconto = 0;
    desconto = 0;
    _iniBuscaClientePedido();
    _initBuscaInfoItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text("Informações do Pedido"),
      ),
      body: Container(
        color: blue,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.80,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Cliente:",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.20,
                                  child: Text(
                                    (cliente != null) ? "${cliente.id}" : "",
                                    style: TextStyle(
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  child: Text(
                                    (cliente != null)
                                        ? "${cliente.nomeRazao}"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Valor do Pedido:",
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.20,
                                  child: Text(
                                    (totalItens == 0)
                                        ? "0 Itens"
                                        : "$totalItens Itens",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  child: Text(
                                    (totalItens == 0)
                                        ? "R\$ 0"
                                        : "R\$ ${valorItens.toStringAsPrecision(4)}",
                                    style: TextStyle(
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.20,
                                  child: GestureDetector(
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Ver Itens",
                                        style:
                                            TextStyle(fontSize: 17, color: blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: (desconto == 0)? false: true,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Text("Desconto:",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.60,
                                    child: Text("R\$ ${valorDesconto.toStringAsPrecision(4)}",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Forma de Pagamento:",
                              style: TextStyle(fontSize: 18),
                            ),
                            DropdownButton(
                              isExpanded: true,
                              value: FpSelecionada,
                              items: formasPagamento.map((FormaPagamento fp) {
                                return new DropdownMenuItem<FormaPagamento>(
                                  child: Text("${fp.descricao}"),
                                  value: fp,
                                );
                              }).toList(),
                              onChanged: (fp) {
                                setState(() {
                                  FpSelecionada = fp;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Desconto:",
                              style: TextStyle(fontSize: 18),
                            ),
                            DropdownButton(
                              isExpanded: true,
                              value: tipoDesconto,
                              items: <DropdownMenuItem<int>>[
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text("SELECIONE"),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text("Porcentagem"),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text("Valor"),
                                ),
                              ],
                              onChanged: (tipo) {
                                setState(() {
                                  tipoDesconto = tipo;
                                  if(tipo != 0){
                                    _confirmarValorDesconto();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                    _actionSalvaPedido();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white),
                    ),
                    alignment: Alignment.center,
                    child: Text("Salvar Pedido", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //buscando os dados do cliente do pedido
  _iniBuscaClientePedido() async {
    final pref = await SharedPreferences.getInstance();
    final idUser = pref.getInt("id_cliente_venda");
    if (idUser != null) {
      RepositoryServiceCliente.getCliente(idUser).then((c) {
        setState(() {
          cliente = c;
        });
      });
    } else {
      Navigator.pop(context);
    }
  }

  //busca as informações dos itens
  _initBuscaInfoItens() {
    RepositoryServiceVendas.getItensVenda(idVenda).then((lista) {
      double soma = 0;
      for (Iten iten in lista) {
        soma += iten.pvenda;
      }
      setState(() {
        totalItens = lista.length;
        valorItens = soma;
      });
    });
  }

  //confirmar o valor do desconto
  _confirmarValorDesconto(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text((tipoDesconto == 1)? "Informe a porcentagem de desconto" : "Informe o valor do desconto", style: TextStyle(fontSize: 25.0),),
                  Divider( height: 20.0, color: Colors.transparent,),
                  TextFormField(
                    controller: controllerDesconto,
                    keyboardType: TextInputType.number,
                    onChanged: (valor){
                      setState(() {
                        desconto = int.parse(valor);
                      });
                    },
                  ),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirmar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                _calculaDesconto();
                controllerDesconto.text = "";
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Cancelar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                controllerDesconto.text = "";
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //calcula o desconto
  _calculaDesconto(){
    //Porcentagem
    if(tipoDesconto == 1){
      totalDesconto = (valorItens * desconto ) / 100;
      setState(() {
        valorDesconto = valorItens - totalDesconto;
      });
    }else{
      //valor
      totalDesconto = desconto.toDouble();
      setState(() {
        valorDesconto = valorItens - totalDesconto;
      });
    }

  }


  //Loading
  _exibeLoading(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                    ),
                    Text("  "),
                    Text("Salvando...", style: TextStyle(fontSize: 25.0),),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //Ação de salvar o pedido
  _actionSalvaPedido(){
    _exibeLoading();
    //salvando o tipo de pagamento
    RepositoryServiceVendas.alteraFormaPagamento(FpSelecionada.id, idVenda).then((resultFp){
      //salvando o cliente do pedido
      RepositoryServiceMunicipios.getMunicipio(cliente.idMunicipio).then((m){
        RepositoryServiceVendas.addCliente(cliente, idVenda, m).then((responseAddCliente){
          //alterando o valor da venda
          RepositoryServiceVendas.alteraValorVenda(valorItens, valorDesconto, totalDesconto, idVenda).then((result){
            Navigator.pushNamedAndRemoveUntil(context, "/inicio", (r) => false);
          });
        });
      });

    });
  }
}
