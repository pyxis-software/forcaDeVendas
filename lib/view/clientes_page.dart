import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/view/sincronizar_dados_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dados_cliente_page.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final Color blue = Color(0xFF3C5A99);
  final _controllerPesquisa = TextEditingController();
  DatabaseCreator database = DatabaseCreator();
  List<Cliente> clientes;
  int cont = 0;
  String textBusca;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (clientes == null) {
      clientes = List<Cliente>();
      _initBuscaClientes();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text("Clientes"),
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
            SizedBox(height: MediaQuery.of(context).padding.bottom,),
          ],
        ),
      ),
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
            ]);
      },
    );
  }

  _logOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('auth', false);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  //Salva dados do textformfield
  salvaTexto(texto) {
    setState(() {
      textBusca = texto;
    });
    buscaClientes(texto);
  }

  //Busca Clientes
  buscaClientes(value) {
    final Future<Database> dbFuture = database.initDatabase();
    dbFuture.then((data) {
      Future<List<Cliente>> clientesFuture =
          RepositoryServiceCliente.buscaCliente(value);
      clientesFuture.then((lista) {
        setState(() {
          clientes = lista;
          cont = lista.length;
        });
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
            //busca o município do cliente
            RepositoryServiceMunicipios.getMunicipio(clientes[index].idMunicipio).then((m){
              //envia o usuário para tela dos dados do cliente
              Navigator.push( context,  MaterialPageRoute(builder: (context) => DadosCliente(c: clientes[index], municipio: m,),));
            });

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
                child: Text("CPF/CNPJ: ${clientes[index].cpfCnpj}",
                  style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _initBuscaClientes() {
    final Future<Database> dbFuture = database.initDatabase();
    dbFuture.then((data) {
      Future<List<Cliente>> clientesFuture =
          RepositoryServiceCliente.getAllClientes();
      clientesFuture.then((lista) {
        setState(() {
          clientes = lista;
          cont = lista.length;
        });
      });
    });
  }
  void _exibePermissaoSinc() {
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
                  Image.asset('lib/assets/alerta.png', width: 50, height: 50,),
                  Divider( height: 20.0, color: Colors.transparent,),
                  Text("Você precisa sincronizar os dados antes de cadastrar um novo cliente!", style: TextStyle(fontSize: 25.0),),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sincronizar"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => SincronizarDados(),));
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


