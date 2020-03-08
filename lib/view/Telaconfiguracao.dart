import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TelaConfiguracao extends StatefulWidget {
  @override
  _TelaConfiguracaoState createState() => _TelaConfiguracaoState();
}

class _TelaConfiguracaoState extends State<TelaConfiguracao> {
  
  final _controllerHost =  TextEditingController();
  final _controllerId = TextEditingController();
  ProgressDialog load;
  String erro;
  var dir;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscaHost();
    erro = "";
    load = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Configuração'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  autocorrect: true,
                  showCursor: true,
                  controller: _controllerHost,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(color: Colors.blueAccent, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Host",
                    labelStyle: TextStyle(color: Colors.blueAccent)
                  ),
                ),
                Divider( height: 20),
                TextFormField(
                  autofocus: true,
                  autocorrect: true,
                  showCursor: true,
                  controller: _controllerId,
                  keyboardType: TextInputType.number,
                  style: new TextStyle(color: Colors.blueAccent, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Id",
                    labelStyle: TextStyle(color: Colors.blueAccent)
                  ),
                ),
                Divider(height: 20),
                ButtonTheme(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () => actionSalvar(),
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color.fromARGB(100, 255, 183, 50),
                  ),
                ),
                Divider(height: 30),
                Text(
                  erro,
                  style: TextStyle(fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  //Busca o host salvo
  void buscaHost() async{
    final pref = await SharedPreferences.getInstance();
    String h = pref.getString('host');
    String id = pref.getString('id_vend');
    print(h);
    if(h != null && id != null){
      setState(() {
        _controllerHost.text = h;
        _controllerId.text = id;
      });
    }
  }
  exibeLoad(bool ativo, String message){
    if(ativo){
      load.style(
        message: message,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
      );
      load.show();
    }else{
      setState(() {
        load.hide();
        load.update();
      });
    }
  }

  actionSalvar() async {
    exibeLoad(true, "Salvando...");
    String campo = _controllerHost.text;
    String id = _controllerId.text;
    print(campo);
    if(campo == null || id == null){
      setState(() {
        erro = "Campos em Branco";
      });
      
    }else{
      final pref = await SharedPreferences.getInstance();
      pref.setString('host', campo);
      pref.setString('id_vend', id);
      //
      getAuth(campo, id);
    }
  }

  Future<Auth> getAuth(String host, String id) async {
    //recebendo os dados da API
      Map<String, String> headers = {"Content-type": "application/json",  "Accept": "application/json",};
      String url = 'https://padraotorrent.com/Backend/pages/api/mobile/getTorrents.php';
      String url2 = 'http://208.115.211.85:5005/api/lotuserpcgi.exe/forcavendas/getususario?idusuario=1';
      var auth;
      
      var response = await http.get('$url2');
      if(response.statusCode == 200){
        auth = Auth.fromJson(json.decode(response.body));
        print(auth.usuarioId);
      }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Configurações Salvas Com Sucesso!",
          style: TextStyle(fontSize: 25, color: Colors.green)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}