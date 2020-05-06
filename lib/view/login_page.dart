import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/controller/functions.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/tela_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'configracao_page.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  //Cor padrão do aplicativo
  final Color blue = Color(0xFF3C5A99);

  //Controladores dos campos de texto
  final _controllerUser = TextEditingController();
  final _controllerPassword = TextEditingController();

  //Checkbox
  bool salvaAuth = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: blue,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    "lib/assets/logo.png",
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                  controller: _controllerUser,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    labelText: "Login",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    labelText: "Senha",
                  ),
                ),
                SizedBox(height: 50,),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      actionLogin();
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaConfiguracao()));
                    },
                    child: Text(
                      "Configurar",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: blue,
                  ),
                ),
              ],
            ),
          ),

          //Botões em baixo
          Positioned(
            top: MediaQuery.of(context).size.height - 150,
            child: Column(
              children: <Widget>[

              ],
            ),
          ),
        ],
      ),
    );
  }

  /*Actions*/
  actionLogin() async {
    String user = _controllerUser.text;
    String pass = _controllerPassword.text;
    Usuario usuario;
    if (user.isEmpty || pass.isEmpty) {
      _errorDadosInput("Campos em Branco!");
    } else {
      final pref = await SharedPreferences.getInstance();
      final data = pref.getString('usuario');
      if (data != null) {
        usuario = Usuario.fromJson(data);
      } else {
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelaConfiguracao()),
        );
      }
      String senhaConvert = textToMd5(pass);
      print(senhaConvert);
      if (user == usuario.usuarioNome && senhaConvert == usuario.usuarioSenha) {
        //Entra sem salvar o login
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaHome()));
        /*
        //verifica se o  usuário quer salvar seu login
        if (false) {
          //entra salvando o login
          final pref = await SharedPreferences.getInstance();
          pref.setBool('auth', true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaHome()));
        } else {
          //Entra sem salvar o login
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaHome()));
        }
        */
      } else {
        _errorDadosInput("Nome de usuário ou senha incorreta");
      }
    }
  }

  _errorDadosInput(String mensagem) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'lib/assets/alerta.png',
                width: 50,
                height: 50,
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Container(
                  child: Text(
                mensagem,
                style: TextStyle(fontSize: 25.0),
              )),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
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
