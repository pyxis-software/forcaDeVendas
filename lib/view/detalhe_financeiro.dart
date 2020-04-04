import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_financeiro.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/financeiro.dart';
import 'package:intl/intl.dart';

class DetalheFinanceiro extends StatefulWidget {
  final Cliente c;
  const DetalheFinanceiro({Key key, this.c}) : super(key: key);

  @override
  _DetalheFinanceiroState createState() => _DetalheFinanceiroState();
}

class _DetalheFinanceiroState extends State<DetalheFinanceiro> {
  final Color blue = Color(0xFF3C5A99);
  int cont;
  List<FinanceiroCliente> financeiro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cont = 0;
    if (financeiro == null) {
      financeiro = List<FinanceiroCliente>();
    }
    _getFinanceiro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financeiro"),
        backgroundColor: blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            //Primeiro Container com as informações do usuário (codigo e CPF/CNPJ)
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Razão Social",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: blue),
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
                            "${widget.c.nomeRazao}",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                          Text("CPF/CNPJ"),
                          Text(
                            "${widget.c.cpfCnpj}",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),

            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),

            //Títulos em atraso
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Text(
                    "Títulos em Atraso",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: blue),
                  ),
                ],
              ),
            ),
            //
            Container(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.3),
                    1: FractionColumnWidth(.3),
                    2: FractionColumnWidth(.2),
                    3: FractionColumnWidth(.2)
                  },
                  children: [
                    _criarLinhaTable("Documento,Vencimento,Atraso,Valor"),
                  ],
                ),
              ),
            ),
            //mostra os produtos disponíves
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width,
                child: _criaLista(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*FUNÇÕES*/
  _criarLinhaTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontSize: 16.0),
          ),
          padding: EdgeInsets.all(5.0),
        );
      }).toList(),
    );
  }

  //retorna o tempo de atraso do vencimento
  _getTotalVencimento(d){
    final data = d.split("/");
    final time = DateTime(int.parse(data[2]), int.parse(data[1]), int.parse(data[0]));
    final diferencia = time.difference(DateTime.now()).inDays;
    if(diferencia < 0){
      return (diferencia * -1);
    }
    return diferencia;
  }

  _getFinanceiro() async {
    RepositoryServiceFinanceiro.getAllClienteFinanceiro(widget.c.id)
        .then((valor) {
      setState(() {
        financeiro = valor;
        cont = valor.length;
        print(cont);
      });
    });
  }

  //
  _criaLista() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cont,
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Table(
                    columnWidths: {
                      0: FractionColumnWidth(.3),
                      1: FractionColumnWidth(.3),
                      2: FractionColumnWidth(.2),
                      3: FractionColumnWidth(.2)
                    },
                    children: [
                      TableRow(children: [
                        Text("${financeiro[index].id}", textAlign: TextAlign.center,),
                        Text("${financeiro[index].dataVecto}", textAlign: TextAlign.center,),
                        Text("${_getTotalVencimento(financeiro[index].dataVecto)}", textAlign: TextAlign.center,),
                        Text("R\$ ${financeiro[index].valorDoc}", textAlign: TextAlign.center,),
                      ]),
                    ],
                  ),
                ),
                Divider(height: 8.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
