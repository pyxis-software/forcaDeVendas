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
  final _controllerUser =  TextEditingController();
  final _controllerPassword =  TextEditingController();

  //Checkbox
  bool salvaAuth = false;
  ProgressDialog load;
  
  
  @override
  void initState(){
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
        backgroundColor: Colors.blueAccent,
        title: const Text('SalesForce'),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracao()),);
              },
            ),
          ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 180,
                  child: Image.asset("lib/assets/splash.jpg"),
                ),
                TextFormField(
                  autocorrect: true,
                  controller: _controllerUser,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(color: Colors.blueAccent, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    labelStyle: TextStyle(color: Colors.blueAccent)
                  ),
                ),
                Divider(),
                TextFormField(
                  obscureText: true,
                  controller: _controllerPassword,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(color: Colors.blueAccent, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.blueAccent)
                  ),
                ),
                Divider(height: 30.0),
                ButtonTheme(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () => actionLogin(),
                    child: Text(
                      "Fazer Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color.fromARGB(100, 255, 183, 50),
                ),
              ),
              Divider(height: 30),
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
      ),
    ),
  );
}

  actionLogin() async{
    String user = _controllerUser.text;
    String pass = _controllerPassword.text;
    Usuario usuario;
    if(user.isEmpty || pass.isEmpty){
      _showDialog("Campos sem informações!");
    }else{
      final pref = await SharedPreferences.getInstance();
      final data = pref.getString('usuario');
      if(data != null){
        usuario = Usuario.fromJson(data);
      }else{
        return Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracao()),);
      }
      String senhaConvert = textToMd5(pass);
      print(senhaConvert);
      if(user == usuario.usuarioNome && senhaConvert == usuario.usuarioSenha){
        //verifica se o  usuário quer salvar seu login
        if(salvaAuth){
          //entra salvando o login
        }else{
          //Entra sem salvar o login
          final pref = await SharedPreferences.getInstance();
          pref.setBool('auth', true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaInicial()));
        }
      }else{
        _showDialog("Nome de usuário ou senha incorreta");
      }
    }
  }

  void _showDialog(String mensagem) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(mensagem,
          style: TextStyle(fontSize: 25, color: Colors.green)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
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