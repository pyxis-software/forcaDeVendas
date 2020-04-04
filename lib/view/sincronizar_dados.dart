import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/functions.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
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
  final Color blue = Color(0xFF3C5A99);
  String host;
  String token = "YWRtaW46YWRtaW4=";
  String messageLog;
  double percent;

  @override
  void initState() {
    super.initState();
    //iniciando a busca pelo host
    buscaHost();
    percent = 0.0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Color(0xFF3C5A99),
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
                        Icon(Icons.sync, size: 50, color: Colors.white,),
                        Text("  "),
                        Text(
                          "Sincronizar",
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
                      _showDialogConfirm();
                    },
                  ),
                ),
              ),
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

    try{
      /*LISTA DE PRODUTOS*/
      var respostaProdutos = await http.get(
        "http://$host:5005/forcavendas/getprodutos?idempresa=${usuario.empresaId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      if(salvaProdutos(respostaProdutos, percent)){
        setState(() {
          percent += 0.1;
        });
        /*LISTA DE MUNICÍPIOS*/
        var respostaMunicipios = await http.get(
          "http://$host:5005/forcavendas/getmunicipios?idcolaborador=${usuario.colaboradorId}",
          headers: {HttpHeaders.authorizationHeader: "Basic $token"},
        );

        if(salvaMunicipios(respostaMunicipios, percent)){
          setState(() {
            percent += 0.1;
          });
          /*LISTA DE FORMAS DE PAGAMENTO*/
          var respostaFormaPagamento = await http.get(
            "http://$host:5005/forcavendas/getformaspagtos?idempresa=${usuario.empresaId}",
            headers: {HttpHeaders.authorizationHeader: "Basic $token"},
          );

          if(salvaFormasPagamento(respostaFormaPagamento, percent)){
            setState(() {
              percent += 0.1;
            });
            /*LISTA DE FORMAS DE PAGAMENTO*/
            var respostaTiposCliente = await http.get(
              "http://$host:5005/forcavendas/getclientestipos",
              headers: {HttpHeaders.authorizationHeader: "Basic $token"},
            );

            if(salvaTipoClientes(respostaTiposCliente, percent)){
              setState(() {
                percent += 0.1;
              });
              /*LISTA DE STATUS DE CLIENTES*/
              var respostaStatusClientes = await http.get(
                "http://$host:5005/forcavendas/getclientesstatus",
                headers: {HttpHeaders.authorizationHeader: "Basic $token"},
              );

              if(salvaStatusCliente(respostaStatusClientes, percent)){
                var respostaFinanceiroClientes = await http.get(
                  "http://$host:5005/forcavendas/getclientesfinanceiro?idvendedor=${usuario.colaboradorId}",
                  headers: {HttpHeaders.authorizationHeader: "Basic $token"},
                );
                if(salvaFinanceiroCliente(respostaFinanceiroClientes)){
                  //
                }else{
                  print("Erro ao adicionar as finanças dos clientes");
                  Navigator.pop(context);
                  _errorAlert("2");
                }
              }else{
                print("Erro ao adicionar os status dos clientes");
                Navigator.pop(context);
                _errorAlert("2");
              }
            }else{
              print("Erro ao adicionar os tipos de clientes");
              Navigator.pop(context);
              _errorAlert("2");
            }

          }else{
            print("Erro ao adicionar as formas de pagamento");
            Navigator.pop(context);
            _errorAlert("2");
          }
        }else{
          print("Erro ao adicionar os municípios");
          Navigator.pop(context);
          _errorAlert("2");
        }
      }else{
        print("Erro ao adicionar os produtos");
        Navigator.pop(context);
        _errorAlert("2");
      }
    }catch (e){
      //Mostra erro de internet
      Navigator.pop(context);
      _errorAlert("1");
    }

    //salvando os clientes
    _salvaClientes(usuario);
  }

  _salvaClientes(Usuario usuario) async {
    //Buscando a lista de clientes
    List<Cliente> clientes = List<Cliente>();
    List<Cliente> clientesEnviaAPI = List<Cliente>();
    RepositoryServiceCliente.getAllClientes().then((lista){
      clientes = lista;
      //buscando os clientes da API
      var respostaClientes = http.get(
        "http://$host:5005/forcavendas/getclientes?idvendedor=${usuario.colaboradorId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      respostaClientes.then((data){
        if(data.statusCode == 200){
          final listaClientes = json.decode(data.body).cast<Map<String, dynamic>>();
          List<Cliente> listaAPI = listaClientes.map<Cliente>((json) {
            return Cliente.fromJson(json);
          }).toList();

          //Percorrendo os clientes do banco
          for(Cliente banco in clientes){
            bool existe = false;
            //percorrendo todos os cliente vindos da API
            for(Cliente api in listaAPI){
              if(banco.id == api.id){
                existe = true;
              }
            }
            if(!existe){
              //adiciona o cliente na lista para enviar para api
              clientesEnviaAPI.add(banco);
            }
          }
          print("Total de clientes a serem enviados: ${clientesEnviaAPI.length}");

          //se existir clientes para enviar, envia
          if(clientesEnviaAPI.length > 0) {
            //envia para o servidor
            for (Cliente c in clientesEnviaAPI) {
              Map<String, dynamic> toJson() =>
                  {
                    "id": 0,
                    "tp_pessoa": c.tpPessoa,
                    "cpf_cnpj": c.cpfCnpj,
                    "nome_razao": c.nomeRazao,
                    "apelido_fantasia": c.apelidoFantasia,
                    "rg_insc": c.rgInsc,
                    "insc_municipal": (c.inscMunicipal.isEmpty)? null : c.inscMunicipal,
                    "fone1": c.fone1,
                    "fone2": (c.fone2.isEmpty) ? null : c.fone2,
                    "fone3": (c.fone3.isEmpty) ? null : c.fone3,
                    "cep": c.cep,
                    "endereco": c.endereco,
                    "endereco_numero": c.enderecoNumero,
                    "complemento": (c.complemento.isEmpty) ? null : c.complemento,
                    "bairro": c.bairro,
                    "id_municipio": c.idMunicipio,
                    "id_status": c.idStatus,
                    "id_cliente_tipo": c.idClienteTipo,
                    "email": c.email,
                    "id_vendedor": usuario.colaboradorId
                  };
              String dados = _convertToBase64(toJson().toString());
              print(dados);
              print(json.encode(toJson()));
              try {
                print("Enviando o cliente: ${c.nomeRazao}");
                var respostaClientesEnviaAPI = http.get(
                    "http://$host:5005/forcavendas/postclientes?objson=$dados",
                    headers: {
                      HttpHeaders.authorizationHeader: "Basic $token"
                    },
                );
                respostaClientesEnviaAPI.then((data) {
                  print(data.statusCode);
                  if (data.statusCode == 200) {
                    print("Retorno do cliente ${c.nomeRazao}:");
                    //REMOVE O CLIENTE DO BANCO
                    RepositoryServiceCliente.deleteCliente(c);
                  } else {
                    print("Erro ao enviar cliente para o servidor!");
                    Navigator.pop(context);
                    _errorAlert("2");
                  }
                });
              } catch (e) {
                print("Erro ao buscar clientes da API");
                Navigator.pop(context);
                _errorAlert("2");
              }
            }
          }else{
            var respostaClientes = http.get(
              "http://$host:5005/forcavendas/getclientes?idvendedor=${usuario.colaboradorId}",
              headers: {HttpHeaders.authorizationHeader: "Basic $token"},
            );
            respostaClientes.then((data) {
              if (data.statusCode == 200) {
                final listaClientes = json.decode(data.body).cast<
                    Map<String, dynamic>>();
                List<Cliente> listaAPI = listaClientes.map<Cliente>((json) {
                  return Cliente.fromJson(json);
                }).toList();
                //Enviando todos os clientes que vieram da API
                for(Cliente cl in listaAPI){
                  //enviando cada cliente para o banco de dados
                  RepositoryServiceCliente.addCliente(cl).then((value){
                    print("Cliente com o ID $value armazenado!");
                  });
                }
                //sai da funcao
                salvaDataSync();
                Navigator.pop(context);
                _exibeSuccess();
              }
            });
          }

        }else{
          print("Erro ao buscar clientes da API");
          Navigator.pop(context);
          _errorAlert("2");
        }
      });
    });
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                    ),
                    Text("  "),
                    Text("Sincronizando...", style: TextStyle(fontSize: 25.0),),
                  ],
                ),
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
                Navigator.pushNamedAndRemoveUntil(context, "/inicio", (r) => false);
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

String _convertToBase64(String valor) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(valor);
  return encoded;
}