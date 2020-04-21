import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/model/forma_pagamento.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:forca_de_vendas/model/venda.dart';
class AlteraInfoPedido extends StatefulWidget {
  final Venda venda;
  final List<FormaPagamento> formasPagamento;
  const AlteraInfoPedido({Key key, this.formasPagamento, this.venda}) : super(key: key);

  @override
  _AlteraInfoPedidoState createState() => _AlteraInfoPedidoState();
}

class _AlteraInfoPedidoState extends State<AlteraInfoPedido> {
  final Color blue = Color(0xFF3C5A99);

  //lista de formas de pagamento
  List<FormaPagamento> formasPagamento;

  //forma de pagamento selecionada
  FormaPagamento FpSelecionada;

  //id da venda
  Venda v;

  //Controller do campo de desconto
  final controllerDesconto = TextEditingController();
  int tipoDesconto;
  int desconto;
  double valorDesconto;
  double totalDesconto;

  //valor dos itens
  double valorItens;

  //total de itens
  int totalItens;

  List<Iten> itens;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    v = widget.venda;
    formasPagamento = widget.formasPagamento;
    valorDesconto = 0;
    totalDesconto = 0;
    tipoDesconto = 0;
    desconto = 0;
    //seleciona o forma do pedido
    _selectFormaPagamento();
    _initBuscaInfoItens();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar Outras Informações"),
        backgroundColor: blue,
      ),
      body: Container(
        color: blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(20),
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
                        RepositoryServiceVendas.alteraFormaPagamento(FpSelecionada.id, v.id);
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
    );
  }

  void _selectFormaPagamento() {
    FpSelecionada = formasPagamento[0];
    for (FormaPagamento fp in formasPagamento){
      if(fp.id == v.idFpagto){
        print(fp.id);
        setState(() {
          FpSelecionada = fp;
        });
      }
    }
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
  //busca as informações dos itens
  _initBuscaInfoItens() {
    RepositoryServiceVendas.getItensVenda(v.id).then((lista) {
      double soma = 0;
      for (Iten iten in lista) {
        soma += iten.pvenda;
      }
      setState(() {
        totalItens = lista.length;
        valorItens = soma;
        itens = lista;
      });
    });
  }
}
