import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/creator_database.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:forca_de_vendas/view/dados_cliente.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';  

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {

  final _controllerPesquisa =  TextEditingController();
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
    if(clientes == null){
      clientes = List<Cliente>();
      _initBuscaClientes();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  padding: EdgeInsets.all(2.0),
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
                          onChanged: (value){
                            salvaTexto(value);
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

                        ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person_add),
                                Text("    "),
                                Text(
                                  "Adicionar Cliente",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                            
                            color: Color.fromARGB(100, 255, 183, 50),
                          ),
                        ),
                        Divider(height: 10.0, color: Colors.transparent,),
                        
                        Table(
                          columnWidths: {0: FractionColumnWidth(.2), 1: FractionColumnWidth(.4), 2: FractionColumnWidth(.4)},
                          children: [
                            _criarLinhaTable("Código,Nome,CPF/CNPJ"),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: (MediaQuery.of(context).size.height / 1.8),
                            child: _criaLista(),
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
          ]
        );
      },
    );
  }
    
  _logOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('auth',false);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
  }

  //Salva dados do textformfield
  salvaTexto(texto){
    setState(() {
      textBusca = texto;
    });
    buscaClientes(texto);
  }
    
  //Busca Clientes
  buscaClientes(value){
    final Future<Database> dbFuture = database.initDatabase();
    dbFuture.then((data){
      Future<List<Cliente>> clientesFuture = RepositoryServiceCliente.buscaCliente(value);
      clientesFuture.then((lista){
        setState(() {
          clientes = lista;
          cont = lista.length;
        });
      });
    });
  }
    
  _criaLista(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cont,
      itemBuilder: (context, index){
        return Container(
          
          child: GestureDetector(
            onTap: (){
              Municipio m;
              RepositoryServiceMunicipios.getMunicipio(clientes[index].idMunicipio).then((municipio){
                m = municipio;
                Navigator.push(
                context,MaterialPageRoute(builder: (context) => DadosCliente(c: clientes[index], municipio: m,),
                ));
              });
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Table(
                    columnWidths: {0: FractionColumnWidth(.2), 1: FractionColumnWidth(.4), 2: FractionColumnWidth(.4)},
                    children: [
                      TableRow(
                        children: [
                          Text("${clientes[index].id}", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("${clientes[index].nomeRazao}", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${clientes[index].cpfCnpj}", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
                        ]
                      ),
                    ],
                  ),
                ),
                Divider( height: 8.0),
              ],
            ),
          ),
        );
      },
    );
  }
    
  void _initBuscaClientes() {
    //String j = '{"codigo": 1903,"cpf": "00.000.000/0001-00","nome": "Emerson Ribeiro Dos Santos","endereco": "Av. Rui Barbosa, 375 Sala 301 - A","bairro": "Casa Amarela","cidade": "Salgueiro","estado": "Pernambuco","cep": "56000-000","telefone": "(87)3031-000","celular": "(81)99535-2990"}';
    //Cliente c = Cliente.fromJson(json.decode(j));
    //RepositoryServiceCliente.addCliente(c);
    
    final Future<Database> dbFuture = database.initDatabase();
    dbFuture.then((data){
      Future<List<Cliente>> clientesFuture = RepositoryServiceCliente.getAllClientes();
      clientesFuture.then((lista){
        setState(() {
          clientes = lista;
          cont = lista.length;
        });
      });
    });
  }
}