import 'dart:math';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/controller/repositorio_service_agendamento.dart';
import 'package:forca_de_vendas/model/agendamento.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/configracao_page.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgendarCliente extends StatefulWidget {
  final Cliente cliente;

  const AgendarCliente({Key key, this.cliente}) : super(key: key);

  @override
  _AgendarClienteState createState() => _AgendarClienteState();
}

class _AgendarClienteState extends State<AgendarCliente> {
  DateTime value;
  final Color blue = Color(0xFF3C5A99);

  //Random
  var randomizer = new Random();

  //Observações
  var inputObservacoes = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          title: Text("Agendar Visita"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  //Primeiro Container com as informações do usuário (codigo e CPF/CNPJ)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width) * 0.4,
                          height: (MediaQuery.of(context).size.height) * 0.2,
                          child: Text(""),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width) * 0.55,
                          height: (MediaQuery.of(context).size.height) * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(12.0),
                                width:
                                    (MediaQuery.of(context).size.width) * 0.55,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Código"),
                                    Text("${widget.cliente.id}",
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(12.0),
                                width:
                                    (MediaQuery.of(context).size.width) * 0.55,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("CPF/CNPJ"),
                                    Text(
                                      "${widget.cliente.cpfCnpj}",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(210, 234, 188, 53),
                      border: Border.all(),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Nome"),
                        Text(
                          "${widget.cliente.nomeRazao}",
                          style: TextStyle(
                              fontSize: 19.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Data do Agendamento",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: DateTimeField(
                            format: format,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  initialDate: currentValue ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2022));
                            },
                            onChanged: (date) {
                              setState(() {
                                value = date;
                              });
                            },
                            onSaved: (date) {
                              setState(() {
                                value = date;
                              });
                            },
                          ),
                        ),
                        Divider(
                          height: 10.0,
                        ),
                        Container(
                          child: Text(
                            "Observações",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(border: Border.all()),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              enableSuggestions: true,
                              textCapitalization: TextCapitalization.characters,
                              maxLines: 8,
                              controller: inputObservacoes,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Suas observações aqui"),
                            )),
                      ],
                    ),
                  ),

                  Divider(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          height: 60.0,
                          child: RaisedButton(
                              onPressed: () => {_actionSalvaAgendamento()},
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.save_alt,
                                      size: 50.0,
                                    ),
                                    Text(
                                      "Salvar",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              color: Color.fromARGB(210, 234, 188, 53)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  //Ação de salvar o agendamento
  _actionSalvaAgendamento() async {
    //exibindo um loading
    _exibeLoading();

    //buscando os dados do usuário
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

    //verifica se o cliente escreveu alguma coisa
    if (inputObservacoes.text == "" || inputObservacoes.text == null) {
      _errorAlert("2");
    } else {
      //criando o objeto de agendamento
      int id = randomizer.nextInt(10000);
      Map<String, dynamic> agendamentoMap() => {
            "id": id,
            "id_pessoa": widget.cliente.id,
            "nome_cliente": widget.cliente.nomeRazao,
            "id_vendedor": usuario.usuarioId,
            "data": value.toString(),
            "observacao": inputObservacoes.text,
            "visitou": 0
          };

      //convertendo no objeto
      Agendamento agendamento = Agendamento.fromMap(agendamentoMap());

      //adicionando no banco de dados
      RepositoryServiceAgendamento.addAgendamento(agendamento).then((result) {
        if (result != null) {
          //sucesso
          _exibeSuccess();
        } else {
          //erro
          print("Erro");
        }
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
                      "Salvando...",
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
                "Cliente Agendado!",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Concluir"),
              onPressed: () {
                Navigator.pop(context);
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
                "Observação está em branco!",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
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
