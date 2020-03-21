import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/functions.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/TelaInicial.dart';
import 'package:forca_de_vendas/view/Telaconfiguracao.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _controllerUser = TextEditingController();
  final _controllerPassword = TextEditingController();

  //Checkbox
  bool salvaAuth = false;
  ProgressDialog load;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3C5A99),
        title: const Text('Força de Vendas'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaConfiguracao()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("lib/assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // autofocus: true,
              controller: _controllerUser,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Usuário",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _controllerPassword,
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                ),
                onPressed: () => {},
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Entrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () {
                    actionLogin();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                    value: salvaAuth,
                    onChanged: (value){
                      setState(() {
                        salvaAuth = value;
                      });
                    }
                ),
                Text(
                  "Lembrar-me",
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            )
          ],
        ),
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
        //verifica se o  usuário quer salvar seu login
        if (salvaAuth) {
          //entra salvando o login
          final pref = await SharedPreferences.getInstance();
          pref.setBool('auth', true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaInicial()));
        } else {
          //Entra sem salvar o login
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TelaInicial()));
        }
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
