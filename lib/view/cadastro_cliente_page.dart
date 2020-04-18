import 'dart:convert';
import 'dart:math';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repository_service_cliente.dart';
import 'package:forca_de_vendas/model/cliente.dart';
import 'package:forca_de_vendas/model/clientes_status.dart';
import 'package:forca_de_vendas/model/municipio.dart';
import 'package:forca_de_vendas/model/tipo_cliente.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastroCliente extends StatefulWidget {
  final List<TipoCliente> tp;
  final List<Municipio> m;
  final List<ClienteStatus> st;

  const TelaCadastroCliente({Key key, this.tp, this.m, this.st})
      : super(key: key);
  @override
  _TelaCadastroClienteState createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  //variáveis diversas
  final _formKey = GlobalKey<FormState>();
  final Color blue = Color(0xFF3C5A99);
  var randomizer = new Random(20);

  //variáveis de controle de input
  List<TipoCliente> tipoClientes;
  TipoCliente selected;
  List<Municipio> municipios;
  Municipio municipio;
  int tipoPessoa = 0;
  List<ClienteStatus> status;
  ClienteStatus statusSelected;

  //variáveis do formulário
  var inputCPFCNPJ = TextEditingController();
  var inputNome = TextEditingController();
  var inputApelido = TextEditingController();
  var inputLogradouro = TextEditingController();
  var inputNumero = TextEditingController();
  var inputComplemento = TextEditingController();
  var inputRGINSCRICAO = TextEditingController();
  var inputCEP = TextEditingController();
  var inputTel1 = TextEditingController();
  var inputTel2 = TextEditingController();
  var inputTel3 = TextEditingController();
  var inputBairro = TextEditingController();
  var inputInsMun = TextEditingController();
  var inputEmail = TextEditingController();

  //
  var maskInputCPF = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  var maskInputCNPJ = MaskTextInputFormatter(
      mask: "##.###.###/####-##", filter: {"#": RegExp(r'[0-9]')});
  var maskCEP = MaskTextInputFormatter(
      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
  var maskTelefone1 = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  var maskTelefone2 = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  var maskTelefone3 = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  //estados das variáveis
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tipoClientes = widget.tp;
    municipios = widget.m;
    status = widget.st;
    statusSelected = status[0];
    municipio = municipios[0];
    selected = tipoClientes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3C5A99),
          title: Text('Adicionar Cliente'),
        ),
        body: _layoytReady());
  }

  _layoytReady() {
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
                          isExpanded: true,
                          hint: Text(
                            "Selecione",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          value: tipoPessoa,
                          items: [
                            DropdownMenuItem(
                              value: 0,
                              child: Text(
                                "FÍSICA",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                "JURÍDICA",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ],
                          onChanged: (tp) {
                            setState(() {
                              tipoPessoa = tp;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Tipo de Cliente"),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text("Selecione"),
                          value: selected,
                          items: tipoClientes.map((TipoCliente tp) {
                            return DropdownMenuItem<TipoCliente>(
                              value: tp,
                              child: Text(
                                tp.descricao,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            );
                          }).toList(),
                          onChanged: (tp) {
                            print(tp.id);
                            setState(() {
                              selected = tp;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Status Do Cliente"),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text("Selecione"),
                          value: statusSelected,
                          items: status.map((ClienteStatus cs) {
                            return DropdownMenuItem<ClienteStatus>(
                              value: cs,
                              child: Text(cs.descricao),
                            );
                          }).toList(),
                          onChanged: (tp) {
                            print(tp.id);
                            setState(() {
                              statusSelected = tp;
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
                    maxLength: (tipoPessoa == 0) ? 14 : 18,
                    inputFormatters: [
                      (tipoPessoa == 0 ? maskInputCPF : maskInputCNPJ)
                    ],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "${tipoPessoa == 0 ? 'CPF' : 'CNPF'}",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: inputRGINSCRICAO,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText:
                          "${tipoPessoa == 0 ? 'RG' : 'INSCRIÇÃO ESTADUAL'}",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),

                  _criaInputInscricaoMunicipal(),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 60,
                    controller: inputNome,
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    controller: inputApelido,
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

                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    controller: inputEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),

                ],
              ),
            ),
            Divider(height: 20.0, color: blue),
            Text(
              "Localização",
              style: TextStyle(fontSize: 20.0),
            ),
            Divider(height: 20.0, color: Colors.transparent),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: inputLogradouro,
                    maxLength: 30,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Logradouro",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Table(
                          children: [
                            TableRow(children: [
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: TextFormField(
                                  controller: inputNumero,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Numero",
                                    labelStyle: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 20),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Preencha o campo";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: TextFormField(
                                  controller: inputComplemento,
                                  maxLength: 30,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Complemento",
                                    labelStyle: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 20),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Preencha o campo";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ])
                          ],
                        ),
                      ],
                    ),
                  ),

                  TextFormField(
                    controller: inputCEP,
                    maxLength: 9,
                    inputFormatters: [maskCEP],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "CEP",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: inputBairro,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Bairro",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Município"),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text("Selecione"),
                          value: municipio,
                          items: municipios.map((Municipio m) {
                            return DropdownMenuItem<Municipio>(
                              value: m,
                              child: Text(
                                "${m.municipioNome} - ${m.municipioEstado}",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            );
                          }).toList(),
                          onChanged: (s) {
                            setState(() {
                              municipio = s;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ),
            Divider(height: 20.0, color: blue),
            Text(
              "Meios de Contato",
              style: TextStyle(fontSize: 20.0),
            ),
            Divider(height: 20.0, color: Colors.transparent),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: inputTel1,
                    inputFormatters: [maskTelefone1],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Telefone 1",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha o campo";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: inputTel2,
                    inputFormatters: [maskTelefone2],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Telefone 2",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),

                  TextFormField(
                    controller: inputTel3,
                    inputFormatters: [maskTelefone3],
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Telefone 3",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  //
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
                      _exibeLoading("Processando...");
                      //verifica os dados enviados
                      if(tipoPessoa == 0){
                        //verifica o cpf
                        if(CPF.isValid(maskInputCPF.getMaskedText())){
                          _criaJSON();
                        }else{
                          //erro
                          Navigator.pop(context);
                          _errorAlert("Verifique o CPF");
                        }
                      }else{
                        //verifica o CNPJ
                        if(CNPJ.isValid(maskInputCNPJ.getMaskedText())){
                          _criaJSON();
                        }else{
                          //erro
                          Navigator.pop(context);
                          _errorAlert("Verifique o CNPJ");
                        }
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  /*FUNÇÕES DA PÁGINA*/

  //Cria o input de inscrição municipal
  Widget _criaInputInscricaoMunicipal(){
    if(tipoPessoa == 0){
      return Container();
    }else{
      return TextFormField(
        controller: inputInsMun,
        textCapitalization: TextCapitalization.characters,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText:
          "INSCRÇÃO MUNICIPAL",
          labelStyle: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        style: TextStyle(fontSize: 20),
      );
    }
  }

  //Loading alert
  _exibeLoading(message){
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
                    Text(message, style: TextStyle(fontSize: 25.0),),
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
                  Text("Cliente Adicionado Com Sucesso!", style: TextStyle(fontSize: 25.0),),
                ],
              )
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Finalizar"),
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

  //Erro Sincronização
  _errorAlert(String message){
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
                  Text(message, style: TextStyle(fontSize: 25.0),),
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

  //Cria o JSON dos dados
  _criaJSON(){
    int id = randomizer.nextInt(1000);
    Map<String, dynamic> toJson () => {
      "id": id,
      "tp_pessoa": tipoPessoa,
      "cpf_cnpj": (tipoPessoa == 0)? maskInputCPF.getUnmaskedText() : maskInputCNPJ.getUnmaskedText(),
      "nome_razao": inputNome.text,
      "apelido_fantasia": inputApelido.text,
      "rg_insc": inputRGINSCRICAO.text,
      "insc_municipal": inputInsMun.text,
      "fone1": maskTelefone1.getUnmaskedText(),
      "fone2": maskTelefone2.getUnmaskedText(),
      "fone3": maskTelefone3.getUnmaskedText(),
      "cep": maskCEP.getUnmaskedText(),
      "endereco": inputLogradouro.text,
      "endereco_numero": inputNumero.text,
      "complemento": inputComplemento.text,
      "bairro": inputBairro.text,
      "id_municipio": municipio.idMunicipio,
      "id_status": statusSelected.id,
      "id_cliente_tipo": selected.id,
      "email" : inputEmail.text,
      "limite_credito": 0,
      "total_pendente": 0.0,
      "limite_disponivel": 0.0
    };
    print(toJson());
    Cliente c = Cliente.fromMap(toJson());
    //armazenando o cliente
    RepositoryServiceCliente.addCliente(c).then((data){
      print(data);
      if(data == id){
        Navigator.pop(context);
        _exibeSuccess();
      }
    });
  }
}
