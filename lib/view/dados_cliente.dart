import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/view/agendar_cliente.dart';
import 'package:forca_de_vendas/view/financeiro.dart';

class DadosCliente extends StatefulWidget {
  final Cliente c;

  const DadosCliente({Key key, this.c}) : super(key: key);
  @override
  _DadosClienteState createState() => _DadosClienteState();
}

class _DadosClienteState extends State<DadosCliente> {

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados do Cliente"),
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.4,
                        height: (MediaQuery.of(context).size.height) * 0.2,
                        child: Text("Nada Aqui"),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.55,
                        height: (MediaQuery.of(context).size.height) * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: (MediaQuery.of(context).size.width) * 0.55,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Código"),
                                  Text("${widget.c.codigo}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12.0),
                              width: (MediaQuery.of(context).size.width) * 0.55,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("CPF/CNPJ"),
                                  Text("${widget.c.cpf}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
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
                      Text("${widget.c.nome}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
                Divider(height: 10.0,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Column(
                    children: <Widget>[
                      Table(
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border.all()
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Endereço"),
                                    Text("${widget.c.endereco}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
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
                                    Text("Bairro"),
                                    Text("${widget.c.bairro}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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
                                    Text("Cidade"),
                                    Text("${widget.c.cidade}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
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
                                    Text("Estado"),
                                    Text("${widget.c.estado}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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
                                    Text("CEP"),
                                    Text("${widget.c.cep}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),
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
                                    Text("Telefone"),
                                    Text("${widget.c.telefone}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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
                                    Text("Celular"),
                                    Text("${widget.c.celular}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ]
                          )
                        ],
                      ),

                    ],
                  ),
                ),

                Divider(height: 100,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        height: 60.0,
                        child: RaisedButton(
                          onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Financeiro(c : widget.c)),);
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
                                  "Consultar Financeiro",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          color: Color.fromARGB(210, 234, 188, 53)
                        ),
                      ),
                      Divider(height: 10.0,),
                      ButtonTheme(
                        height: 60.0,
                        child: RaisedButton(
                          onPressed: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AgendarCliente(cliente : widget.c)),)
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  size: 50.0,
                                  ),
                                Text(
                                  "Agendamento",
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
      )
    );
  }
}