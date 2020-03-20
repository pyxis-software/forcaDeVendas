
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/TelaInicial.dart';
import 'package:forca_de_vendas/view/Telaconfiguracao.dart';
import 'package:forca_de_vendas/view/clientes.dart';
import 'package:forca_de_vendas/view/financeiro.dart';
import 'package:forca_de_vendas/view/produtos.dart';
import 'package:forca_de_vendas/view/sincronizar_dados.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var db;

getDataUsuario(String id, String host) async {
  //buscando os dados da API
  String url = "http://$host:5005/api/lotuserpcgi.exe/forcavendas/getususario?idusuario=$id";
  print(url);
  var resposta = await http.get(url);
  if(resposta.statusCode == 200){
    print(resposta.body);
  }else{
    print("Erro");
  }
}
//Retorna o Drawer
getDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        ListTile(
          selected: true,
          leading: Icon(Icons.supervised_user_circle),
          title: Text("Clientes"),
          subtitle: Text("Meus Clientes..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Clientes()),);
          }
        ),
        ListTile(
          leading: Icon(Icons.local_offer),
          title: Text("Produtos"),
          subtitle: Text("Meus Produtos..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaProdutos()),);
          }
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Pedidos"),
          subtitle: Text("Meus Pedidos..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Financeiro()),);
          }
        ),
        ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: Text("Relatórios"),
          subtitle: Text("Meus Relatórios..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaInicial()),);
          }
        ),
        ListTile(
          leading: Icon(Icons.sync),
          title: Text("Sincronizar Dados"),
          subtitle: Text("Enviar para o servidor..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SincronizarDados()),);
          }
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Configurações"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
          }
        ),
      ],
    ),
  );
}

//Converte String em MD5
String textToMd5 (String text) {
  return md5.convert(utf8.encode(text)).toString().toUpperCase();
}