import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/functions.dart';
import 'package:forca_de_vendas/controller/repositorio_service_agendamento.dart';
import 'package:forca_de_vendas/controller/repositorio_service_vendas.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/agendamento.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/iten.dart';
import 'package:forca_de_vendas/model/itens_venda.dart';
import 'package:forca_de_vendas/model/result_pedido.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/model/venda.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'configracao_page.dart';

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
  bool enviarIsVisible;
  bool receberIsVisible;

  //Checkbox
  bool checkProdutos;
  bool checkMunicipios;
  bool checkFormas;
  bool checkClientes;

  @override
  void initState() {
    super.initState();
    //iniciando a busca pelo host
    buscaHost();
    enviarIsVisible = false;
    receberIsVisible = false;
    percent = 0.0;

    //
    checkProdutos = true;
    checkMunicipios = true;
    checkFormas = true;
    checkClientes = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text("Sincronizar Dados"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              //Botão para selecionar o que quer fazer
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
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
                          "Enviar Dados",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blue,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text("   "),
                        Icon(
                          (!enviarIsVisible)
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: blue,
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        enviarIsVisible = !enviarIsVisible;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //Visualização da tela de enviar dados
              Visibility(
                visible: enviarIsVisible,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      //Clientes
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.person),
                              Text(
                                "Clientes",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Pedidos
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.insert_drive_file),
                              Text(
                                "Pedidos",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Agendamentos
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.date_range),
                              Text(
                                "Agendamentos",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      //Botão de ação de enviar dos dados
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: blue,
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
                                  "Enviar",
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
                              _actionEnviar();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(
                height: 10,
              ),

              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
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
                          "Receber Dados",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blue,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Icon(
                          (!receberIsVisible)
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: blue,
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        receberIsVisible = !receberIsVisible;
                      });
                    },
                  ),
                ),
              ),

              //Dados a serem recebidos
              //Visualização da tela de enviar dados
              Visibility(
                visible: receberIsVisible,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      //Tabelas Auxiliares
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkMunicipios,
                                  onChanged: (value) {
                                    setState(() {
                                      checkMunicipios = value;
                                    });
                                  }),
                              Icon(Icons.location_city),
                              Text(
                                "Municípios",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Produtos
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkProdutos,
                                  onChanged: (value) {
                                    setState(() {
                                      checkProdutos = value;
                                    });
                                  }),
                              Icon(Icons.account_balance_wallet),
                              Text(
                                "Produtos",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Clientes
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkClientes,
                                  onChanged: (value) {
                                    setState(() {
                                      checkClientes = value;
                                    });
                                  }),
                              Icon(Icons.account_balance_wallet),
                              Text(
                                "Clientes",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Produtos
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: checkFormas,
                                  onChanged: (value) {
                                    setState(() {
                                      checkFormas = value;
                                    });
                                  }),
                              Icon(Icons.payment),
                              Text(
                                "Formas de Pagamento",
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Botão de ação de receber os dados
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: blue,
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
                                  "Receber",
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
                              _actionReceber();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Receber dados da API
  _actionReceber() async {
    //Exibe o loading
    _exibeLoading();
    Usuario usuario;
    //Buscando os dados do usuário do sistema
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('usuario');
    if (data != null) {
      usuario = Usuario.fromJson(data);
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaConfiguracao()),
      );
    }

    try {
      /*LISTA DE PRODUTOS*/
      var respostaProdutos = await http.get(
        "http://$host:5005/forcavendas/getprodutos?idempresa=${usuario.empresaId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      /*LISTA DE MUNICÍPIOS*/
      var respostaMunicipios = await http.get(
        "http://$host:5005/forcavendas/getmunicipios?idcolaborador=${usuario.colaboradorId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      /*LISTA DE FORMAS DE PAGAMENTO*/
      var respostaFormaPagamento = await http.get(
        "http://$host:5005/forcavendas/getformaspagtos?idempresa=${usuario.empresaId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      /*LISTA DE CLIENTES*/
      var respostaTiposCliente = await http.get(
        "http://$host:5005/forcavendas/getclientestipos",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      /*LISTA DE STATUS DE CLIENTES*/
      var respostaStatusClientes = await http.get(
        "http://$host:5005/forcavendas/getclientesstatus",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      var respostaFinanceiroClientes = await http.get(
        "http://$host:5005/forcavendas/getclientesfinanceiro?idvendedor=${usuario.colaboradorId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );

      //salvando os dados
      if (checkProdutos) {
        salvaProdutos(respostaProdutos);
      }
      if (checkMunicipios) {
        salvaMunicipios(respostaMunicipios);
      }

      if (checkFormas) {
        salvaFormasPagamento(respostaFormaPagamento);
      }
      salvaTipoClientes(respostaTiposCliente);
      salvaStatusCliente(respostaStatusClientes);
      salvaFinanceiroCliente(respostaFinanceiroClientes);

      if (checkClientes) {
        _salvaClientes(usuario);
      } else {
        Navigator.pop(context);
        _exibeSuccess();
      }
    } catch (e) {
      //Mostra erro de internet
      Navigator.pop(context);
      _errorAlert("1");
    }
  }

  //Enviar Dados para API
  _actionEnviar() async {
    //Exibe o loading
    _exibeLoading();
    Usuario usuario;
    //Buscando os dados do usuário do sistema
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('usuario');
    if (data != null) {
      usuario = Usuario.fromJson(data);
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaConfiguracao()),
      );
    }
    _salvaAgendamentos();
    _salvaClientes(usuario);
    _salvaVendas();
  }

  _salvaClientes(Usuario usuario) async {
    //Buscando a lista de clientes
    List<Cliente> clientes = List<Cliente>();
    List<Cliente> clientesEnviaAPI = List<Cliente>();
    RepositoryServiceCliente.getAllClientes().then((lista) {
      clientes = lista;
      //buscando os clientes da API
      var respostaClientes = http.get(
        "http://$host:5005/forcavendas/getclientes?idvendedor=${usuario.colaboradorId}",
        headers: {HttpHeaders.authorizationHeader: "Basic $token"},
      );
      respostaClientes.then((data) {
        if (data.statusCode == 200) {
          final listaClientes =
              json.decode(data.body).cast<Map<String, dynamic>>();
          List<Cliente> listaAPI = listaClientes.map<Cliente>((json) {
            return Cliente.fromJson(json);
          }).toList();

          //Percorrendo os clientes do banco
          for (Cliente banco in clientes) {
            bool existe = false;
            //percorrendo todos os cliente vindos da API
            for (Cliente api in listaAPI) {
              if (banco.id == api.id) {
                existe = true;
              }
            }
            if (!existe) {
              //adiciona o cliente na lista para enviar para api
              clientesEnviaAPI.add(banco);
            }
          }
          print(
              "Total de clientes a serem enviados: ${clientesEnviaAPI.length}");

          //se existir clientes para enviar, envia
          if (clientesEnviaAPI.length > 0) {
            //envia para o servidor
            for (Cliente c in clientesEnviaAPI) {
              Map<String, dynamic> toJson() => {
                    "id": 0,
                    "tp_pessoa": c.tpPessoa,
                    "cpf_cnpj": c.cpfCnpj,
                    "nome_razao": c.nomeRazao,
                    "apelido_fantasia": c.apelidoFantasia,
                    "rg_insc": c.rgInsc,
                    "insc_municipal":
                        (c.inscMunicipal.isEmpty) ? null : c.inscMunicipal,
                    "fone1": c.fone1,
                    "fone2": (c.fone2.isEmpty) ? null : c.fone2,
                    "fone3": (c.fone3.isEmpty) ? null : c.fone3,
                    "cep": c.cep,
                    "endereco": c.endereco,
                    "endereco_numero": c.enderecoNumero,
                    "complemento":
                        (c.complemento.isEmpty) ? null : c.complemento,
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
                  headers: {HttpHeaders.authorizationHeader: "Basic $token"},
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
            Navigator.pop(context);
            _exibeSuccess();
          } else {
            var respostaClientes = http.get(
              "http://$host:5005/forcavendas/getclientes?idvendedor=${usuario.colaboradorId}",
              headers: {HttpHeaders.authorizationHeader: "Basic $token"},
            );
            respostaClientes.then((data) {
              if (data.statusCode == 200) {
                final listaClientes =
                    json.decode(data.body).cast<Map<String, dynamic>>();
                List<Cliente> listaAPI = listaClientes.map<Cliente>((json) {
                  return Cliente.fromJson(json);
                }).toList();
                //Enviando todos os clientes que vieram da API
                for (Cliente cl in listaAPI) {
                  //enviando cada cliente para o banco de dados
                  RepositoryServiceCliente.addCliente(cl).then((value) {
                    print("Cliente com o ID $value armazenado!");
                  });
                }
              }
            });
            Navigator.pop(context);
            _exibeSuccess();
          }
        } else {
          print("Erro ao buscar clientes da API");
          Navigator.pop(context);
          _errorAlert("2");
        }
      });
    });
  }

  void buscaHost() async {
    final pref = await SharedPreferences.getInstance();
    String h = pref.getString('host');
    String id = pref.getString('id_vend');
    print(h);
    if (h != null && id != null) {
      setState(() {
        host = h;
      });
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("  "),
                    Text(
                      "Sincronizando...",
                      style: TextStyle(fontSize: 25.0),
                    ),
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
                "Dados Sincronizados com sucesso!",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Finalizar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //mostra que pedido não foi selecionado o cliente
  _exibeSuccessClientePedido(Venda venda) {
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
                "Dados Sincronizados!",
                style: TextStyle(fontSize: 25.0),
              ),
              Divider(
                height: 50.0,
                color: Colors.transparent,
              ),
              Text(
                "Pedido ${venda.id} não foi processada por não ter cliente selecionado",
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Finalizar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //Erro Sincronização
  _errorAlert(String codigo) {
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
                "Erro ao sincronizar!",
                style: TextStyle(fontSize: 25.0),
              ),
              Text(
                "Verifique sua internet!",
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

  void _salvaVendas() {
    //buscando todas as vendas que não foram faturadas ainda
    RepositoryServiceVendas.getVendasEmAberto().then((listaVendas) {
      if (listaVendas.length > 0) {
        //existe vendas a serem sincronizadas

        bool isErro = false;
        //Percorrendo a lista de vendas

        for (Venda venda in listaVendas) {
          //Verifica se a venda tem cliente
          if (venda.idCliente != 0) {
            //Tem cliente selecionado
            //buscando os itens da venda
            RepositoryServiceVendas.getItensVenda(venda.id).then((listaItens) {
              //criando o json da venda
              String listaString = "";
              List<ItensVenda> itens = List<ItensVenda>();
              int item = 1;
              for (Iten iten in listaItens) {
                Map<String, dynamic> jsonIten() => {
                      "item": item,
                      "id_produto": iten.idProduto,
                      "complemento": "",
                      "vlr_vendido": iten.pvenda,
                      "qtde": iten.qtdVenda,
                      "tot_bruto": (iten.qtdVenda * iten.pvenda),
                      "vlr_desc_prc": 0,
                      "vlr_desc_vlr": 0,
                      "vlr_liquido": (iten.qtdVenda * iten.pvenda),
                      "grade": iten.grade,
                      "id_vendedor": venda.idVendedor,
                    };
                itens.add(ItensVenda.fromMap(jsonIten()));
                item += 1;
              }
              Map<String, dynamic> jsonDados() => {
                    "data_venda": venda.dataVenda,
                    "id_empresa": venda.idEmpresa,
                    "id_cliente": venda.idCliente,
                    "id_vendedor": venda.idVendedor,
                    "id_fpagto": venda.idFpagto,
                    "id_usuario": venda.idUsuario,
                    "tot_bruto": venda.totBruto,
                    "tot_desc_prc": venda.totDescPrc,
                    "tot_desc_vlr": venda.totDescVlr,
                    "tot_liquido": venda.totLiquido,
                    "itens": itens,
                    "lat": venda.lat,
                    "lng": venda.lng
                  };

              print(json.encode(jsonDados()));

              //enviando os dados para a API
              String dados = _convertToBase64(json.encode(jsonDados()));
              print(dados);
              var responseAPIPostVenda = http.get(
                "http://$host:5005/forcavendas/postpedidos?objson=$dados",
                headers: {HttpHeaders.authorizationHeader: "Basic $token"},
              ).then((response) {
                print(response.body.toString());
                if (response.statusCode == 200) {
                  if (!response.body.contains("result")) {
                    isErro = true;
                    Navigator.pop(context);
                    _errorAlert("4");
                  } else {
                    //pegando o id do pedido
                    ResultPedido res = ResultPedido.fromJson(
                        json.decode(response.body.toString()));
                    print(res.result);

                    RepositoryServiceVendas.alteraStatus(venda, res);
                    if (!isErro) {
                      Navigator.pop(context);
                      _exibeSuccess();
                    }
                  }
                }
              });
            });
          } else {
            print("Pedido ${venda.id} sem cliente selecionado!");
            Navigator.pop(context);
            _exibeSuccessClientePedido(venda);
          }
        }
      } else {
        Navigator.pop(context);
        _exibeSuccess();
      }
    });
  }

  void _salvaAgendamentos() async {
    //buscandos os agendamentos
    RepositoryServiceAgendamento.getAllAgendamentos().then((lista) {
      for (Agendamento agendamento in lista) {
        //criando o Map do objeto
        Map<String, dynamic> agendamentoMap() => {
              "id": agendamento.id,
              "id_pessoa": agendamento.idPessoa,
              "id_vendedor": agendamento.idVendedor,
              "data": _convertToFormatAPI(agendamento.data),
              "observacao": agendamento.observacao,
              "visitou": agendamento.visitou
            };

        //Criando o base64 dos dados
        String dados = _convertToBase64(json.encode(agendamentoMap()));
        print(dados);

        //enviando os dado para API
        var responseAPIAgendamento = http.get(
          "http://$host:5005/forcavendas/postclientesvisitas?objson=$dados",
          headers: {HttpHeaders.authorizationHeader: "Basic $token"},
        ).then((response) {
          if (response.statusCode == 200) {
            if (!response.body.contains("result")) {
              Navigator.pop(context);
              _errorAlert("4");
            } else {
              //pegando o id do agendamento
              ResultPedido res =
                  ResultPedido.fromJson(json.decode(response.body.toString()));
              if(agendamento.visitou == 0){
                //alterando o ID do agendamento
                RepositoryServiceAgendamento.alteraIdAgendamento(agendamento, res);
              }else{
                //removendo o agendamento
                RepositoryServiceAgendamento.apagaAgendamento(agendamento);
              }
            }
          }
        });
      }
    });
  }
}

//converte data em formato da API
_convertToFormatAPI(String format) {
  var parsedDate = DateTime.parse(format);
  var dia;
  var mes;
  var ano = parsedDate.year;

  //dia
  if(parsedDate.day < 10){
    dia = "0${parsedDate.day}";
  }

  //mes
  if(parsedDate.month < 10){
    mes = "0${parsedDate.month}";
  }
  return "$dia$mes$ano";
}

String _convertToBase64(String valor) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(valor);
  return encoded;
}
