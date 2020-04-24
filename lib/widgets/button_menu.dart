import 'package:flutter/material.dart';
import 'package:forca_de_vendas/controller/repositorio_service_municipios.dart';
import 'package:forca_de_vendas/controller/repositorio_service_status_cliente.dart';
import 'package:forca_de_vendas/controller/repositorio_service_tipo_cliente.dart';
import 'package:forca_de_vendas/model/usuario.dart';
import 'package:forca_de_vendas/view/cadastro_cliente_page.dart';
import 'package:forca_de_vendas/view/sincronizar_dados_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonMenu extends StatefulWidget {
  final MaterialPageRoute pageRoute;
  final String nome;
  final Icon icone;
  final int tipo;

  const ButtonMenu({Key key, this.pageRoute, this.nome, this.icone, this.tipo})
      : super(key: key);

  @override
  _ButtonMenuState createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    widget.icone,
                    Text("  "),
                    Text(
                      widget.nome,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),
            onPressed: () {
              _actionButton();
            }),
      ),
    );
  }

  void _exibePermissaoSinc() {
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
                "Você precisa sincronizar os dados antes de cadastrar um novo cliente!",
                style: TextStyle(fontSize: 25.0),
              ),
            ],
          )),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sincronizar"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SincronizarDados(),
                    ));
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

  _actionButton() async {
    RepositoryServiceMunicipios.getAllMunicipos().then((lista) {
      print(lista.length);
      if (lista.length == 0) {
        _exibePermissaoSinc();
      } else {
        if (widget.tipo == 0) {
          Navigator.push(context, widget.pageRoute);
        } else {
          //buscando os municipios
          RepositoryServiceMunicipios.getAllMunicipos().then((lista) {
            if (lista.length == 0) {
              _exibePermissaoSinc();
            } else {
              //buscando a lista de tipos de clientes
              RepositoryServiceTipoCliente.getAllTipoCliente()
                  .then((listaTipoPessoa) {
                //buscando a lista de status de clientes
                RepositoryServiceClientesStatus.getAllStatusCliente()
                    .then((listaStatus) {
                  //enviando o usuário para a tela de cadastro de clientes
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaCadastroCliente(
                        st: listaStatus,
                        m: lista,
                        tp: listaTipoPessoa,
                      ),
                    ),
                  );
                });
              });
            }
          });
        }
      }
    });
  }
}
