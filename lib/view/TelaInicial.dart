import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/model/venda.dart';
import 'package:forca_de_vendas/view/Telaconfiguracao.dart';
import 'package:forca_de_vendas/view/clientes.dart';
import 'package:forca_de_vendas/view/pedidos.dart';
import 'package:forca_de_vendas/view/produtos.dart';
import 'package:forca_de_vendas/view/sincronizar_dados.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final Color blue = Color(0xFF3C5A99);
  String dataSync;

  //total faturado e não faturado
  double faturado;
  double naoFaturado;

  @override
  void initState() {
    // TODO: implement initState
    dataSync = "null";
    faturado = 0.0;
    naoFaturado = 0.0;
    _getTotalVendas();
  }

  @override
  Widget build(BuildContext context) {
    _getDataSync();
    return Scaffold(
      //drawer: getDrawer(context),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: Text(
                    'Bem Vindo!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "R\$ ${naoFaturado.toStringAsPrecision(4)}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Não Faturado",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "R\$ ${faturado.toStringAsPrecision(4)}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "Faturado",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _showDialog();
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            Text(
                              'Sair',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            padding: EdgeInsets.all(42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Clientes()),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: blue,
                          ),
                          Text(
                            'Clientes',
                            style: TextStyle(
                                color: blue, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        RepositoryServiceMunicipios.getAllMunicipos().then((total){
                          if(total.length != 0){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaPedidos()),
                            );
                          }else{
                            _exibePermissaoSinc();
                          }
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: blue,
                          ),
                          Text(
                            'Pedidos',
                            style: TextStyle(
                                color: blue, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaProdutos()),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.local_offer,
                            color: blue,
                          ),
                          Text(
                            'Produtos',
                            style: TextStyle(
                                color: blue, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.insert_drive_file,
                          color: blue,
                        ),
                        Text(
                          'Relatórios',
                          style: TextStyle(
                              color: blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaConfiguracao()),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: blue,
                          ),
                          Text(
                            'Configurações',
                            style: TextStyle(
                                color: blue, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: blue,
                        ),
                        Text(
                          'Sobre',
                          style: TextStyle(
                              color: blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    height: 200,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                      child: SizedBox.expand(
                        child: FlatButton(
                          child: Column(
                            children: <Widget>[
                              Text(
                                dataSync,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3C5A99),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                height: 30,
                                color: Colors.transparent,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.sync,
                                    size: 50,
                                    color: Color(0xFF3C5A99),
                                  ),
                                  Text(
                                    "Sincronizar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3C5A99),
                                      fontSize: 35,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SincronizarDados()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*FUNÇÕES*/

  //Log out
  _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('auth', false);
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
            ]);
      },
    );
  }

  void _getDataSync() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('data_sync');
    setState(() {
      if (data == null) {
        dataSync = "Sincronize os dados com o servidor!";
      } else {
        final cont = DateTime.now().difference(DateTime.parse(data));
        if (cont.inDays > 0) {
          final d = DateTime.parse(data);
          dataSync = "Última Sincronização realizada a $cont atrás";
        } else {
          dataSync = "Última Sincronização realizada hoje!";
        }
      }
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
                  Text("Você precisa sincronizar os dados antes de cadastrar uma nova venda!", style: TextStyle(fontSize: 25.0),),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sincronizar"),
              onPressed: () {
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

  //busca o total das vendas
  _getTotalVendas(){
    RepositoryServiceVendas.getVendasEmAberto().then((lista){
      double total = 0.0;
      for (Venda venda in lista){
        total += venda.totLiquido;
      }
      setState(() {
        naoFaturado = total;
      });
    });

    //faturados
    RepositoryServiceVendas.getVendasFaturado().then((lista){
      double total = 0.0;
      for (Venda venda in lista){
        total += venda.totLiquido;
      }
      setState(() {
        faturado = total;
      });
    });
  }
}
