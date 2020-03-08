import 'package:flutter/material.dart';
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
    print(user);
    if(user == null || pass == null){
      print("Sem dados");
    }else{
      //verifica se o  usuário quer salvar seu login
      if(salvaAuth){
        //entra sanlvando o login
      }else{
        //Entra sem salvar o login
        final pref = await SharedPreferences.getInstance();
        pref.setBool('auth', true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => TelaInicial()),);
      }
    }
  }
}