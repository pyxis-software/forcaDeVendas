
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repositorio_service_pagamentos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_tipo_cliente.dart';
import 'package:forca_de_vendas/model/forma_pagamento.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:forca_de_vendas/model/produto.dart';
import 'package:forca_de_vendas/model/tipo_cliente.dart';
import 'package:forca_de_vendas/view/TelaInicial.dart';
import 'package:forca_de_vendas/view/Telaconfiguracao.dart';
import 'package:forca_de_vendas/view/clientes.dart';
import 'package:forca_de_vendas/view/financeiro.dart';
import 'package:forca_de_vendas/view/produtos.dart';
import 'package:forca_de_vendas/view/sincronizar_dados.dart';
import 'package:http/http.dart' as http;

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
            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracao()),);
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

//SALVANDO OS DADOS DO SINCRONISMO

//produtos
bool salvaProdutos(http.Response resposta){
  //verifica se a resposta está correta
  if(resposta.statusCode == 200){
    final listProdutos = json.decode(resposta.body).cast<Map<String, dynamic>>();
    List<Produto> produtos = listProdutos.map<Produto>((json) {
      return Produto.fromJson(json);
    }).toList();

    //Adicionando os produtos no banco de dados
    for(Produto p in produtos){
      Future<int> response = RepositoryServiceProdutos.addProduto(p);
      response.then((data){
        //print(data);
      });
    }
    return true;
  }else{
    //erro
    return false;
  }
}

//municípios
salvaMunicipios(http.Response resposta){
  //verifica se a resposta está correta
  if(resposta.statusCode == 200){
    //verifica se não houve algum erro de dados
    if(resposta.body.toString().contains("MESSAGE")){
      return false;
    }else{
      final listMunicipios = json.decode(resposta.body).cast<Map<String, dynamic>>();
      List<Municipio> municipios = listMunicipios.map<Municipio>((json) {
        return Municipio.fromJson(json);
      }).toList();

      for(Municipio m in municipios){
        RepositoryServiceMunicipios.addMunicipio(m).then((id){
          //print("$id");
        });
      }
      return true;
    }
  }else{
    //erro
    return false;
  }
}

//Salva formas de pagamento
bool salvaFormasPagamento(http.Response resposta){
  //verifica se a resposta está correta
  if(resposta.statusCode == 200){
    //verifica se não houve algum erro de dados
    if(resposta.body.toString().contains("MESSAGE")){
      return false;
    }else{
      final listFormas = json.decode(resposta.body).cast<Map<String, dynamic>>();
      List<FormaPagamento> pagamentos = listFormas.map<FormaPagamento>((json) {
        return FormaPagamento.fromJson(json);
      }).toList();
      for(FormaPagamento fp in pagamentos){
        RepositoryServicePagamentos.addFormaPagamento(fp).then((id){
          //print("$id");
        });
      }
      return true;
    }
  }else{
    //erro
    return false;
  }
}

//Salva os tipos de clientes
bool salvaTipoClientes(http.Response resposta){
  //verifica se a resposta está correta
  if(resposta.statusCode == 200){
    //verifica se não houve algum erro de dados
    if(resposta.body.toString().contains("MESSAGE")){
      return false;
    }else{
      final listTipoCliente = json.decode(resposta.body).cast<Map<String, dynamic>>();
      List<TipoCliente> tiposCliente = listTipoCliente.map<TipoCliente>((json) {
        return TipoCliente.fromJson(json);
      }).toList();
      for(TipoCliente tc in tiposCliente){
        RepositoryServiceTipoCliente.addTipoCliente(tc).then((id){
          //print("$id");
        });
      }
      return true;
    }
  }else{
    //erro
    return false;
  }
}