import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_pedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:forca_de_vendas/controller/functions.dart';
import 'package:forca_de_vendas/model/pedido.dart';
import 'package:forca_de_vendas/view/TelaLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TelaLogin.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  Future<List<Pedido>> pedidos;
  var load;
  
  @override
  void initState() {
    // TODO: implement initState
    load = true;
    _getClientes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SalesForce"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //Sair
                _showDialog();
              },
            ),
        ],
      ),
      drawer: getDrawer(context),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ButtonTheme(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () => {
                      //
                    },
                    child: Text(
                      "Alguma Coisa Aqui",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color.fromARGB(100, 255, 183, 50),
                ),
              ),
              Divider(height: 20.0,),
              Expanded(
                child: _getListPedidos(),
              ),
              ],
            ),
          ),
        ),
    );
  }

  /*FUNÇÕES*/
  
  //Log out
  _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('auth',false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaLogin()));
  }

  //Confirmação de Log out
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sair"),
          content: new Text("Confirme que deseja sair"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
              
            ),
            new FlatButton(
              child: new Text("Sair"),
              onPressed: () {
                _logOut();
              },
            )
          ]
        );
      },
    );
  }

  //getClientes
  _getClientes() async {
    pedidos = RepositoryServicePedido.getAllPedidos();
  }

  //Lista os clientes
  _getListPedidos(){
    return FutureBuilder(
      future: pedidos,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return _criaLista(snapshot);
        }else{
          return Container(
            child: Text("Sem Pedidos!"),
          );
        }
      },
    );
  }

  //Cria a visualização
 Widget _criaLista(pedido){
    return Card(
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: ( (MediaQuery.of(context).size.width*80) / 100),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 2.0, right: 10.0),
                        child: Text("${pedido.codigo}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.0, right: 10.0),
                        child: Text("${pedido.cidade}", style: TextStyle(fontSize: 20.0),),
                      )
                    ],
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.transparent,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                        "${pedido.nome}",
                        style: TextStyle(fontSize: 20.0,),
                        overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.transparent,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 2.0, right: 10.0),
                        child: Text("${pedido.data}", style: TextStyle(fontSize: 20.0),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.0, right: 10.0),
                        child: Text("R\$ ${pedido.valor}", style: TextStyle(fontSize: 20.0, color: Colors.red,),),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Container(
                        width: ( (MediaQuery.of(context).size.width*30) / 100),
                        child: ButtonTheme(
                          height: 20.0,
                          child: RaisedButton(
                            onPressed: () => {
                              
                            },
                            color: Color.fromARGB(100, 255, 183, 50),
                            child: Icon(
                              Icons.edit
                            )
                          ),
                        ),
                      ),
                      Container(
                        width: ( (MediaQuery.of(context).size.width*20) / 100),
                      ),
                      Container(
                        width: ( (MediaQuery.of(context).size.width*30) / 100),
                        child: ButtonTheme(
                          height: 30.0,
                          child: RaisedButton(
                            color: Color.fromARGB(100, 255, 183, 50),
                            onPressed: () => {
                              
                            },
                            child: Icon(
                              Icons.restore_from_trash
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        )
      ),
    );
  }
}