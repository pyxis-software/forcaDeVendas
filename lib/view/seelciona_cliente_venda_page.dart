import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_pagamentos.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/view/informacao_vendas_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaSelecionaClienteVenda extends StatefulWidget {
  final int idVenda;

  const TelaSelecionaClienteVenda({Key key, this.idVenda}) : super(key: key);
  @override
  _TelaSelecionaClienteVendaState createState() =>
      _TelaSelecionaClienteVendaState();
}

class _TelaSelecionaClienteVendaState extends State<TelaSelecionaClienteVenda> {
  final Color blue = Color(0xFF3C5A99);
  List<Cliente> clientes;
  final _controllerPesquisa = TextEditingController();
  int cont;

  //Id da venda
  int idVenda;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cont = 0;
    idVenda = widget.idVenda;
  }

  @override
  Widget build(BuildContext context) {
    if (clientes == null) {
      clientes = List<Cliente>();
      _initBuscaClientes();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text("Incluir Cliente no Pedido"),
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
                    Text("Código, Nome ou Apelido"),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      controller: _controllerPesquisa,
                      onChanged: (value) {
                        buscaClientes(value);
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

  void buscaClientes(String value) {
    RepositoryServiceCliente.buscaCliente(value).then((lista) {
      setState(() {
        clientes = lista;
        cont = lista.length;
      });
    });
  }

  void _initBuscaClientes() {
    RepositoryServiceCliente.getAllClientes().then((lista) {
      setState(() {
        clientes = lista;
        cont = lista.length;
      });
    });
  }

  _criaLista() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: cont,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
        height: 20,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
           _confirmClienteSelecionado(clientes[index]);

          },
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("#${clientes[index].id} - ${clientes[index].nomeRazao}",
                  style: TextStyle(fontSize: 20, color: blue, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text("${clientes[index].cpfCnpj}",
                  style: TextStyle(fontSize: 16, color: blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _confirmClienteSelecionado(Cliente cliente){
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
                  Text("Deseja confirmar o cliente?", style: TextStyle(fontSize: 25.0),),
                  Divider( height: 20.0, color: Colors.transparent,),
                  Text("Cliente: ${cliente.nomeRazao}"),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirmar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                _selecionaCliente(cliente);
              },
            ),
          ],
        );
      },
    );
  }

  _criarLinhaTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey,
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

  void _selecionaCliente(Cliente cliente) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt("id_cliente_venda", cliente.id);
    RepositoryServicePagamentos.getAllFormasPagamentos().then((lista){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TelaInformacaoVenda(idVenda: idVenda, formasPagamento: lista,)));
    });
  }
}
