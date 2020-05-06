import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forca_de_vendas/controller/repositeorio_servide_produtos.dart';
import 'package:forca_de_vendas/controller/repositorio_service_agendamento.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/agendamento.dart';
import 'package:forca_de_vendas/view/dados_cliente_page.dart';

class ListaAgendamento extends StatefulWidget {
  ListaAgendamento({Key key}) : super(key: key);

  @override
  _ListaAgendamentoState createState() => _ListaAgendamentoState();
}

class _ListaAgendamentoState extends State<ListaAgendamento> {
  //cor padrão do aplicativo
  final Color blue = Color(0xFF3C5A99);

  //total de agendamentos
  int cont;

  //Lista de agendamentos
  List<Agendamento> agendamentos;

  //verificado o total de agendamentos
  bool verificaTotal;

  @override
  void initState() {
    // TODO: implement initState
    cont = 0;
    verificaTotal = false;

    //iniciando a busca
    _getAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Agendamentos"),
        backgroundColor: blue,
      ),
      body: Container(
          child: (!verificaTotal)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (cont > 0)
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: ListView.separated(
                              itemCount: cont,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //Text("#${agendamentos[index].id}", style: TextStyle(color: blue),),
                                      Text(
                                        "${agendamentos[index].nomeCliente}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: blue,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        _convertDataTime(
                                            agendamentos[index].data),
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                _exibeConfirmacaoVisita(agendamentos[index]);
                                              },
                                              child: Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 50,
                                                child: Center(
                                                  child: Text("Concluir"),
                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                //buscando os dados do cliente
                                                RepositoryServiceCliente
                                                        .getCliente(
                                                            agendamentos[index]
                                                                .idPessoa)
                                                    .then((cliente) {
                                                  //Buscando o municipio do cliente
                                                  RepositoryServiceMunicipios
                                                          .getMunicipio(cliente
                                                              .idMunicipio)
                                                      .then((m) {
                                                    //envia o usuário para tela dos dados do cliente
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DadosCliente(
                                                            c: cliente,
                                                            municipio: m,
                                                          ),
                                                        ));
                                                  });
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(color: blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 50,
                                                child: Center(
                                                  child: Text("Dados do Cliente"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.black,
                                height: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(
                      child: Center(
                        child: Text(
                          "Sem Agendamento!",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )),
    );
  }

  //busca os agendamentos
  _getAgendamentos() async {
    RepositoryServiceAgendamento.getAllAgendamentos().then((listaAgendamentos) {
      setState(() {
        verificaTotal = true;
        cont = listaAgendamentos.length;
        agendamentos = listaAgendamentos;
      });
    });
  }

  //converte data do banco em data visual
  _convertDataTime(String dataBanco) {
    var parsedDate = DateTime.parse(dataBanco);
    return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
  }

  //confirmação de visita
  _exibeConfirmacaoVisita(Agendamento agendamento){
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
              Text(
                "Deseja concluir a visita?",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                _alteraSituacaoAgendamento(agendamento);
                Navigator.pop(context);
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

  //altera para visitado
  _alteraSituacaoAgendamento(Agendamento agendamento){
    //alterando o status do agendamento
    RepositoryServiceAgendamento.alteraEstadoAgendamento(agendamento, 1).then((result){
      _getAgendamentos();
    });

  }
}
