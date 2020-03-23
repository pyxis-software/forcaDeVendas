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

  final String url = 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/09/04/15/lionel-messi-0.jpg?';
  final Color green = Color(0xFF1E8161);
  
  @override
  void initState() {
    // TODO: implement initState
    load = true;
    _getClientes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: getDrawer(context),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        children: <Widget>[
                          Text('Familiar',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text('12',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(url)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: <Widget>[
                          Text('Following',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text('18',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10
                  ),
                  child: Text("ID: 14552566",
                    style: TextStyle(
                        color: Colors.white70
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: Text('Herman Jimenez',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.group_add, color: Colors.white,),
                          Text('Friends',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.group, color: Colors.white,),
                          Text('Groups',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.videocam, color: Colors.white,),
                          Text('Videos',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.favorite, color: Colors.white,),
                          Text('Likes',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/3,
            padding: EdgeInsets.all(42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.table_chart, color: Colors.grey,),
                        Text('Leaders',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.show_chart, color: Colors.grey,),
                        Text('Level up',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.card_giftcard, color: Colors.grey,),
                        Text('Leaders',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.code, color: Colors.grey,),
                        Text('QR code')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.blur_circular, color: Colors.grey,),
                        Text('Daily bonus')
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.visibility, color: Colors.grey,),
                        Text('Visitors')
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /*FUNÇÕES*/
  
  //Log out
  _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('auth',false);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
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