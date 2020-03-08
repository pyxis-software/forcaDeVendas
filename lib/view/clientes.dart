import 'package:flutter/material.dart';
import 'package:forca_de_vendas/view/TelaLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaLogin()));
  }
}