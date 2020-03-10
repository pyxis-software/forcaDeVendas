import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/view/TelaLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {

  final _controllerPesquisa =  TextEditingController();

  Future <List<Cliente>> clientes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initBuscaClientes();
      }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Clientes"),
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
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Pesquisar Cliente"),
                              ],
                            ),
                            TextFormField(
                              controller: _controllerPesquisa,
                              onChanged: (value)=>{
    
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(color: Colors.blueAccent, fontSize: 20),
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderSide: new BorderSide(),
                                ),
                                labelStyle: TextStyle(color: Colors.blueAccent)
                              ),
                            ),
                            Divider(height: 10.0, color: Colors.transparent,),
                            ButtonTheme(
                              height: 60.0,
                              child: RaisedButton(
                                  onPressed: () => {
    
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.search),
                                      Text("Pesquisar"),
                                    ],
                                  ),
                                color: Color.fromARGB(100, 255, 183, 50),
                              ),
                            ),
    
                            Container(
                              child: FutureBuilder(
                                future: clientes,
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return _criaLista(snapshot);
                                  }else{
                                    return Container(
                                      child: Text("Sem Clientes!"),
                                    );
                                  }
                                },
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    
          ),
        );
      }
    
      //Logout
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
    
      _logOut() async {
        final pref = await SharedPreferences.getInstance();
        pref.setBool('auth',false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaLogin()));
      }
    
      //Busca Clientes
      buscaClientes(value){
        setState(() {
           clientes = RepositoryServiceCliente.buscaCliente(value);
        });
       
      }
    
      Widget _criaLista(cliente){
        return Card(
          elevation: 10.0,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(cliente),
          ),
        );
      }
    
      void _initBuscaClientes() {
        String j = '{"codigo": 1905,"cpf": "00.000.000/0001-00","nome": "Emerson Ribeiro Dos Santos","endereco": "Av. Rui Barbosa, 375 Sala 301 - A","bairro": "Casa Amarela","cidade": "Salgueiro","estado": "Pernambuco","cep": "56000-000","telefone": "(87)3031-000","celular": "(81)99535-2990"}';
        Cliente c = Cliente.fromJson(json.decode(j));
        RepositoryServiceCliente.addCliente(c);
        clientes = RepositoryServiceCliente.getAllClientes();
      }
}