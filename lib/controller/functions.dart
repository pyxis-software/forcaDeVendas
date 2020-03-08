
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/view/TelaInicial.dart';
import 'package:forca_de_vendas/view/clientes.dart';
import 'package:forca_de_vendas/view/financeiro.dart';
import 'package:http/http.dart' as http;

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
getDrawer(context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Macoratti"),
          accountEmail: Text("macoratti@yahoo.com"),
          currentAccountPicture: CircleAvatar(
            radius: 30.0,
            backgroundImage: 
          NetworkImage(
'https://img.icons8.com/plasticine/2x/user.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.supervised_user_circle),
          title: Text("Clientes"),
          subtitle: Text("Meus Clientes..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
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
          title: Text("Sinccronizar Dados"),
          subtitle: Text("Enviar para o servidor..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaInicial()),);
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