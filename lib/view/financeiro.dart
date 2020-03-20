import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/cliente.dart';

class Financeiro extends StatefulWidget {
  final Cliente c;

  const Financeiro({Key key, this.c}) : super(key: key);
  @override
  _FinanceiroState createState() => _FinanceiroState();
}

class _FinanceiroState extends State<Financeiro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financeiro"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child:  Column(
              children: <Widget>[
                //Primeiro Container com as informações do usuário (codigo e CPF/CNPJ)
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text("Razão Social",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: Colors.blueAccent
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
                            Text("${widget.c.nome}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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
                            Text("${widget.c.cpf}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                
                Divider(height: 10.0, color: Colors.transparent,),

                //Títulos em atraso
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text("Títulos em Atraso",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: Colors.blueAccent
                        ),
                      ),
                      //
                      Table(
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border.all()
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Quantidade"),
                                    Text("2", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Atraso Médio"),
                                    Text("67 dias", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
                      //
                      Table(
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border.all()
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Valor Total"),
                                    Text("R\$ 300,00", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
                    ],
                  )
                ),

                Divider(height: 10.0, color: Colors.transparent,),

                //Títulos a vencer
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text("Títulos a Vencer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: Colors.blueAccent
                        ),
                      ),
                      //
                      Table(
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border.all()
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Quantidade"),
                                    Text("14", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Valor Total"),
                                    Text("R\$ 6.500,00", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
                    ],
                  )
                ),

                Divider(height: 10.0, color: Colors.transparent,),

                //Crédito
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text("Crédito",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: Colors.blueAccent
                        ),
                      ),
                      //
                      Table(
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border.all()
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Limite de Crédio"),
                                    Text("R\$ 50.000,00", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Limite Disponível"),
                                    Text("R\$ 43.200,00", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
                    ],
                  )
                ),

                Divider(height: 50, color: Colors.transparent,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        height: 60.0,
                        child: RaisedButton(
                          onPressed: () => {
                              print("Pressionou")
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.content_paste,
                                  size: 50.0,
                                  ),
                                Text(
                                  "Detalhamento",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          color: Color.fromARGB(210, 234, 188, 53)
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}