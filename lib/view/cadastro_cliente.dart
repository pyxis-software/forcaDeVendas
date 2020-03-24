import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_tipo_cliente.dart';
import 'package:forca_de_vendas/model/tipo_cliente.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastroCliente extends StatefulWidget {
  @override
  _TelaCadastroClienteState createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  //variáveis diversas
  final _formKey = GlobalKey<FormState>();
  final Color blue = Color(0xFF3C5A99);

  //variáveis de controle de input
  List<TipoCliente> tipoClientes;
  TipoCliente selected;

  //variáveis do formulário
  var inputCPFCNPJ = TextEditingController();
  var maskInputCPF = MaskTextInputFormatter(mask: "###.###.###-##", filter: { "#": RegExp(r'[0-9]') });

  //estados das variáveis
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTipoCliente();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3C5A99),
        title:Text('Adicionar Cliente'),
      ),
      body: _layoytReady()
    );
  }

  _layoytReady(){
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Tipo de Pessoa"),
                        DropdownButton(
                          hint: Text("Selecione"),
                          value: selected,
                          items: tipoClientes.map((TipoCliente tp){
                            return DropdownMenuItem<TipoCliente>(
                              value: tp,
                              child: Text(tp.descricao),
                            );
                          }).toList(),
                          onChanged: (s){
                            setState(() {
                              selected = s;
                            });
                          },
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: inputCPFCNPJ,
                    maxLength: 14,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "CPF/CNPJ (Somente numeros)",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value){
                      if(value.isEmpty){
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome/Razão Social",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value){
                      if(value.isEmpty){
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    // autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Apelido",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),


            Divider(height: 20.0,),
            Text("Localização", style: TextStyle(fontSize: 20.0),),
            Divider(height: 20.0,),

            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: inputCPFCNPJ,
                    maxLength: 30,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Logradoutro",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value){
                      if(value.isEmpty){
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome/Razão Social",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value){
                      if(value.isEmpty){
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    // autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Apelido",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0xFF3C5A99),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Salvar",
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
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Buscando os tipos de clientes
  _getTipoCliente() async{
    Future<List<TipoCliente>> tiposFuture =
    RepositoryServiceTipoCliente.getAllTipoCliente();
    tiposFuture.then((lista) {
      setState(() {
        tipoClientes = lista;
      });
      print(lista.length);
    });
  }
}
