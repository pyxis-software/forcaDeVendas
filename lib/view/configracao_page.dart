import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TelaConfiguracao extends StatefulWidget {
  @override
  _TelaConfiguracaoState createState() => _TelaConfiguracaoState();
}

class _TelaConfiguracaoState extends State<TelaConfiguracao> {
  final _controllerHost = TextEditingController();
  final _controllerId = TextEditingController();
  ProgressDialog load;
  String erro;
  String token = "YWRtaW46YWRtaW4=";

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
          backgroundColor: Color(0xFF3C5A99),
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
                    style:
                        new TextStyle(color: Colors.blueAccent, fontSize: 20),
                    decoration: InputDecoration(
                        labelText: "Host",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    autofocus: true,
                    autocorrect: true,
                    showCursor: true,
                    controller: _controllerId,
                    keyboardType: TextInputType.number,
                    style:
                        new TextStyle(color: Colors.blueAccent, fontSize: 20),
                    decoration: InputDecoration(
                        labelText: "Id Colaborador",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                  Divider(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF3C5A99),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Salvar",
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
                          actionSalvar();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  //Busca o host salvo
  void buscaHost() async {
    final pref = await SharedPreferences.getInstance();
    String h = pref.getString('host');
    String id = pref.getString('id_vend');
    print(h);
    if (h != null && id != null) {
      setState(() {
        _controllerHost.text = h;
        _controllerId.text = id;
      });
    }
  }

  exibeLoad(bool ativo, String message) {
    if (ativo) {
      load.style(
        message: message,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
      );
      load.show();
    } else {
      setState(() {
        load.hide();
        load.update();
      });
    }
  }

  actionSalvar() async {
    _exibeLoading();
    String campo = _controllerHost.text;
    String id = _controllerId.text;
    if (campo.isEmpty || id.isEmpty) {
      Navigator.pop(context);
      _errorDadosInput("Campos em Branco!");
    } else {
      final pref = await SharedPreferences.getInstance();
      pref.setString('host', campo);
      pref.setString('id_vend', id);
      //
      getAuth(campo, id);
    }
  }

  getAuth(String host, String id) async {
    //recebendo os dados da API
    var auth = 'Basic ' + base64Encode(utf8.encode('admin:admin'));
    String url = 'http://$host:5005/forcavendas/getususario?idusuario=$id';
    try {
      var response = await http.get(
        '$url',
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {

        //verifica se existe o usuário
        if(!response.body.toString().contains("MESSAGE")){
          //Recebendo os dados do usuário e armazenando
          final List data = json.decode(response.body);
          final usuario = json.encode(data[0]);

          //Armazenando o JSON com as informações do usuário
          final pref = await SharedPreferences.getInstance();
          pref.setString('usuario', usuario);
          //Exibe alerta de tudo certo
          Navigator.pop(context);
          _exibeSuccess();
        }else{
          Navigator.pop(context);
          _errorAlert(1);
        }
        
      } else {
        Navigator.pop(context);
        _errorAlert(2);
      }
    } catch (e) {
      Navigator.pop(context);
      _errorAlert(3);
    }
  }

  //Loading alert
  _exibeLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                Text("  "),
                Text(
                  "Verificando...",
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //Exibe sincronização concluída
  _exibeSuccess() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'lib/assets/certo.png',
                width: 50,
                height: 50,
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Text(
                "Configurações Salvas!",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Finalizar"),
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

  //Erro Sincronização
  _errorAlert(codigo) {
    String message;
    switch(codigo){
      case 2:
        message = "Verifique o Host Informado!";
        break;
      case 1:
        message = "ID não encontrado!";
        break;
      default:
        message = "Verifique sua internet!";
    }
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
              Image.asset(
                'lib/assets/alerta.png',
                width: 50,
                height: 50,
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Text(
                "Erro ao salvar!",
                style: TextStyle(fontSize: 25.0),
              ),
              Text(
                message,
                style: TextStyle(fontSize: 25.0),
              ),
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

  //Erro nos dados informados
  _errorDadosInput(String mensagem) {
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
              Image.asset(
                'lib/assets/alerta.png',
                width: 50,
                height: 50,
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Text(
                mensagem,
                style: TextStyle(fontSize: 25.0),
              ),
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
