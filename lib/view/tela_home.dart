import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/cadastro_cliente_page.dart';
import 'package:forca_de_vendas/view/clientes_page.dart';
import 'package:forca_de_vendas/view/pedidos_page.dart';
import 'package:forca_de_vendas/view/produtos_page.dart';
import 'package:forca_de_vendas/view/sincronizar_dados_page.dart';
import 'package:forca_de_vendas/view/teste.dart';
import 'package:forca_de_vendas/widgets/button_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configracao_page.dart';

class TelaHome extends StatefulWidget {
  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  //cor padrão do aplicativo
  final Color blue = Color(0xFF3C5A99);

  //controle do acesso do menu dos clientes
  bool menuClienteVisible;

  //variável do usuário
  Usuario usuario;

  //Localização

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuClienteVisible = false;
    _getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        width: 150,
                        child: Image.asset("lib/assets/logo.png"),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        (usuario != null) ? usuario.colaboradorNome : "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Text(
                        (usuario != null) ? usuario.empresaFantasia : "",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF3C5A99),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.people,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text("  "),
                                            Text(
                                              "Clientes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          (!menuClienteVisible)
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_up,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        menuClienteVisible =
                                            !menuClienteVisible;
                                      });
                                    }),
                              ),
                            ),
                            Visibility(
                              visible: menuClienteVisible,
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: <Widget>[
                                    ButtonMenu(
                                      icone: Icon(
                                        Icons.people,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      nome: "Lista de Clientes",
                                      pageRoute: MaterialPageRoute(
                                          builder: (context) => Clientes()),
                                      tipo: 0,
                                    ),
                                    ButtonMenu(
                                      icone: Icon(
                                        Icons.person_add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      nome: "Cadastrar Cliente",
                                      pageRoute: MaterialPageRoute(
                                          builder: (context) =>
                                              TelaCadastroCliente()),
                                      tipo: 1,
                                    ),
                                    //ButtonMenu(icone: Icon(Icons.calendar_today, color: Colors.white, size: 20,), nome: "Agendar Cliente", pageRoute: MaterialPageRoute(builder: (context) => TelaCadastroCliente()),),
                                    //Divider(color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF3C5A99),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.shopping_cart,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text("  "),
                                            Text(
                                              "Pedidos",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TelaPedidos()),
                                      );
                                    }),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF3C5A99),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.local_offer,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text("  "),
                                            Text(
                                              "Produtos",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TelaProdutos()),
                                      );
                                    }),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF3C5A99),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.insert_drive_file,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text("  "),
                                            Text(
                                              "Relatórios",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {}),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Color(0xFF3C5A99),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: SizedBox.expand(
                                child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.sync,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            Text("  "),
                                            Text(
                                              "Sincronizar",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SincronizarDados()),
                                      );
                                    }),
                              ),
                            ),

                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDialog();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "Sair do APP",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //busca as informações do usuário
  _getInfoUser() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('usuario');
    if (data != null) {
      setState(() {
        usuario = Usuario.fromJson(data);
      });
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaConfiguracao()),
      );
    }
  }

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
}
