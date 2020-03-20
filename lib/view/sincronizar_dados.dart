import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/model/produto.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/Telaconfiguracao.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SincronizarDados extends StatefulWidget {

  @override
  _SincronizarDadosState createState() => _SincronizarDadosState();
}

class _SincronizarDadosState extends State<SincronizarDados> {
  //Minhas variáveis
  String host;

  @override
  void initState() {
    super.initState();

    //iniciando a busca pelo host
    buscaHost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Sincronizar Dados"),
       ),
       body: SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(57, 145, 138, 139),
                  border: Border.all()
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("ARQUIVOS", style: TextStyle(fontSize: 25.0),),
                ),
              ),

              //Clientes
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      Text("Clientes", style: TextStyle(fontSize: 25.0),),
                    ],
                  ),
                ),
              ),

              //Tabelas Auxiliares
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text("Tabelas Auxiliares", style: TextStyle(fontSize: 25.0),),
                    ],
                  ),
                ),
              ),

              //Produtos
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.account_balance_wallet),
                      Text("Produtos", style: TextStyle(fontSize: 25.0),),
                    ],
                  ),
                ),
              ),

              //Pedidos
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.insert_drive_file),
                      Text("Pedidos", style: TextStyle(fontSize: 25.0),),
                    ],
                  ),
                ),
              ),

              Divider(height: 20.0,),
              Container(
                child: ButtonTheme(
                  height: 60.0,
                    child: RaisedButton(
                      onPressed: () {
                        _showDialogConfirm();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.cloud_download,size: 40,),
                          Text("Sincronizar com Servidor de Dados",
                            style: TextStyle(color: Colors.black, fontSize:18),
                          ),
                        ],
                      ),
                    color: Color.fromARGB(100, 255, 183, 50),
                  ),
                ),
              )
            ],
          ),
         ),
       ),
    );
  }

  //Ação do botão
  _actionSync() async{
    //Exibe o loading
    _exibeLoading();
    Usuario usuario;
    //Buscando os dados do usuário do sistema
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('usuario');
    if(data != null){
      usuario = Usuario.fromJson(data);
    }else{
      return Navigator.push(context, MaterialPageRoute(builder: (context) => TelaConfiguracao()),);
    }

    //criando a string para buscar os produtos do servidor
    String url = "http://$host:5005/api/lotuserpcgi.exe/forcavendas/getprodutos?idempresa=${usuario.empresaId}";

    //Lista de usuários
    var produtos = new List<Produto>();

    try{
      //Criando a resposta do servidor para a busca de produtos
      var resposta = await http.get(url);
      //Verifica se a resposta foi correta
      if(resposta.statusCode == 200){
        final list = json.decode(resposta.body).cast<Map<String, dynamic>>();
        List<Produto> produtos = list.map<Produto>((json) {
          return Produto.fromJson(json);
        }).toList();

        //Adicionando os produtos no banco de dados
        for(Produto p in produtos){
          print("Código: ${p.idProduto} -- Referência: ${p.grupoNome}");
          Future<int> response = RepositoryServiceProdutos.addProduto(p);
          response.then((data){
            //print(data);
          });
        }

        //Exibe que tudo deu certo
        Navigator.pop(context);
        _exibeSuccess();
      }else{
        //Mostra erro de retorno
        Navigator.pop(context);
        _errorAlert("2");
      }

    }catch (e){
      //Mostra erro de internet
      Navigator.pop(context);
      _errorAlert("1");
    }
    


  }
  void buscaHost() async{
    final pref = await SharedPreferences.getInstance();
    String h = pref.getString('host');
    String id = pref.getString('id_vend');
    print(h);
    if(h != null && id != null){
      setState(() {
        host = h;
      });
    }
  }

  //Confirmação de sincronização
  void _showDialogConfirm() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Deseja Mesmo Sincronizar os Dados?",
          style: TextStyle(fontSize: 25, color: Colors.black)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sincronizar"),
              onPressed: () {
                Navigator.pop(context);
                _actionSync();
              },
            ),
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  
  //Loading alert
  _exibeLoading(){
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
                CircularProgressIndicator(
                ),
                Text("  "),
                Text("Sincronizando...", style: TextStyle(fontSize: 25.0),),
              ],
            ),
          ),
        );
      },
    );
  }

  //Exibe sincronização concluída
  _exibeSuccess(){
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
                Image.asset('lib/assets/certo.png', width: 50, height: 50,),
                Divider( height: 20.0, color: Colors.transparent,),
                Text("Dados Sincronizados com sucesso!", style: TextStyle(fontSize: 25.0),),
              ],
            )
          ),
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
  _errorAlert(String codigo){
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
                Image.asset('lib/assets/alerta.png', width: 50, height: 50,),
                Divider( height: 20.0, color: Colors.transparent,),
                Text("Erro ao sincronizar!", style: TextStyle(fontSize: 25.0),),
                Text("Verifique sua internet!", style: TextStyle(fontSize: 25.0),),
              ],
            )
          ),
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