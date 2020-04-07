import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repositorio_service_status_cliente.dart';
import 'package:forca_de_vendas/controller/repositorio_service_tipo_cliente.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:forca_de_vendas/view/cadastro_cliente.dart';
import 'package:forca_de_vendas/view/dados_cliente.dart';
import 'package:forca_de_vendas/view/sincronizar_dados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blue,
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

            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  onPressed: (){
                    //buscando os municipios
                    RepositoryServiceMunicipios.getAllMunicipos().then((lista){
                      if(lista.length == 0){
                        _exibePermissaoSinc();
                      }else{
                        //buscando a lista de tipos de clientes
                        RepositoryServiceTipoCliente.getAllTipoCliente().then((listaTipoPessoa){
                          //buscando a lista de status de clientes
                          RepositoryServiceClientesStatus.getAllStatusCliente().then((listaStatus){
                            //enviando o usuário para a tela de cadastro de clientes
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadastroCliente(st: listaStatus, m: lista, tp: listaTipoPessoa,)),);
                          });
                        });
                      }
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person_add),
                      Text("Adicionar Cliente", style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ),
              ),
            ),

            //Criando a tabela de amostra
            Container(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.2),
                    1: FractionColumnWidth(.4),
                    2: FractionColumnWidth(.4)
                  },
                  children: [
                    _criarLinhaTable("Código,Nome,CPF/CNPJ"),
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cont,
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            onTap: () {
              Municipio m;
              RepositoryServiceMunicipios.getMunicipio(clientes[index].idMunicipio).then((municipio) {
                m = municipio;
                Navigator.push(context,MaterialPageRoute(builder: (context) => DadosCliente(c: clientes[index],municipio: m,),));
              });
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Table(
                    columnWidths: {
                      0: FractionColumnWidth(.2),
                      1: FractionColumnWidth(.4),
                      2: FractionColumnWidth(.4)
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          "${clientes[index].id}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${clientes[index].nomeRazao}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${clientes[index].cpfCnpj}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                    ],
                  ),
                ),
                Divider(height: 8.0),
              ],
            ),
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


