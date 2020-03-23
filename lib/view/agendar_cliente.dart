import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:intl/intl.dart';

class AgendarCliente extends StatefulWidget {
  final Cliente cliente;

  const AgendarCliente({Key key, this.cliente}) : super(key: key);

  @override
  _AgendarClienteState createState() => _AgendarClienteState();
}

class _AgendarClienteState extends State<AgendarCliente> {
  DateTime value = DateTime.now();
  int motivo = 1;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    return Scaffold(
      appBar: AppBar(
        title: Text("Agendar Visita"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                                  Text("${widget.cliente.id}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
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
                                  Text("${widget.cliente.cpfCnpj}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
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
                      Text("${widget.cliente.nomeRazao}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
                Divider(height: 10.0,),
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
                        child: Text("Data do Agendamento", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: DateTimeField(
                          format: format,
                          onShowPicker: (context, currentValue){
                            return showDatePicker(context: context, initialDate: currentValue ?? DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2022));
                          },
                          onChanged: (date)  {
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
                      Divider(height: 10.0,),
                      Container(
                        child: Text("Motivo do Agendamento", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: DropdownButton(
                          value: motivo,
                          onChanged: (value){
                            setState(() {
                              motivo = value;
                            });
                          },
                          items: <DropdownMenuItem>[
                            DropdownMenuItem(
                              value: 1,
                              child: Text("Um"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Dois"),
                            ),

                          ],
                        ),
                      ),

                      Divider(height: 10.0,),
                      Container(
                        child: Text("Observações", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),

                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all()
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(hintText: "Suas observações aqui"),
                        )
                      ),
                    ],
                  ),
                ),

                Divider(height: 10.0,),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AgendarCliente(cliente : widget.cliente)),)
                          },
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