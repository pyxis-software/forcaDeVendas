import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_financeiro.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/financeiro.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:forca_de_vendas/view/agendar_cliente.dart';

import 'financeiro_page.dart';

class DadosCliente extends StatefulWidget {
  final Cliente c;
  final Municipio municipio;
  const DadosCliente({Key key, this.c, this.municipio}) : super(key: key);
  
  @override
  _DadosClienteState createState() => _DadosClienteState();
}

class _DadosClienteState extends State<DadosCliente> {

  //Criando variáveis
  final Color blue = Color(0xFF3C5A99);
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text("Dados do Cliente"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                                  Text("${widget.c.id}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
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
                                  Text("${widget.c.cpfCnpj ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
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
                      Text("${widget.c.nomeRazao}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
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
                                    Text("${widget.c.endereco ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
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
                              border: Border.all(),
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Bairro"),
                                    Text("${widget.c.bairro ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
                                  ],
                                ),
                              ),
                              Container(

                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Cidade"),
                                    Text("${widget.municipio.municipioNome ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.clip,),
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
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Estado"),
                                    Text("${widget.municipio.municipioEstado ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("CEP"),
                                    Text("${widget.c.cep ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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
                                    Text("Telefone 1"),
                                    Text("${widget.c.fone1 ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Telefone 2"),
                                    Text("${widget.c.fone2 ?? ''}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
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

                Divider(height: 10.0, color: Colors.transparent,),
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
                            //buscando o total de documentos
                            RepositoryServiceFinanceiro.getAllClienteFinanceiro(widget.c.id).then((data){
                              int atraso = 0;
                              double totalAtraso = 0;
                              int vencer = 0;
                              double diasAtraso = 0;
                              double totalAvencer = 0;
                              double media = 0;
                              for(FinanceiroCliente f in data){

                                //Documento em atraso
                                if(_isVencido(f.dataVecto)){
                                  atraso += 1;
                                  totalAtraso += f.valorDoc;
                                  diasAtraso += _getTotalVencimento(f.dataVecto);
                                }

                                //documento a vencer
                                if(!_isVencido(f.dataVecto)){
                                  vencer += 1;
                                  totalAvencer += f.valorDoc;
                                }
                              }
                              media = ( diasAtraso/atraso );
                              if(media.isNaN){
                                media = 0;
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Financeiro(c : widget.c, atraso: atraso, totalAtraso: totalAtraso, vencer: vencer, totalAvencer: totalAvencer, media: media.toInt(),)),);
                            });

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
                          onPressed: () =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AgendarCliente(cliente : widget.c)),),
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

  /*FUNÇÕES*/
  bool _isVencido(d){
    final data = d.split("/");
    final time = DateTime(int.parse(data[2]), int.parse(data[1]), int.parse(data[0]));
    final diferencia = time.difference(DateTime.now()).inDays;
    if(diferencia >= 0){
      return false;
    }else{
      return true;
    }
  }
  _getTotalVencimento(d){
    final data = d.split("/");
    final time = DateTime(int.parse(data[2]), int.parse(data[1]), int.parse(data[0]));
    final diferencia = time.difference(DateTime.now()).inDays;
    if(diferencia < 0){
      return (diferencia * -1);
    }
    return diferencia;
  }
}