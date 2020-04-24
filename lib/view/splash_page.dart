import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/view/tela_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class TelaSplash extends StatefulWidget {
  @override
  _TelaSplashState createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  //Cor padrão do aplicativo
  final Color blue = Color(0xFF3C5A99);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //definindo um delay de 4 segundos para ir para a proxima tela
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_) {
      verificaLogin();
    });
  }

  /*FUNCIONALIDADES*/
  verificaLogin() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("data_sync", null);
    var auth = pref.getBool('auth');
    if (auth != null) {
      //verifica se é true ou false
      if (!auth) {
        //envia o usuário para a tela de login
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TelaLogin()));
      } else {
        //Envia o usuário para a tela inicial
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TelaHome()));
      }
    } else {
      pref.setBool('auth', false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TelaLogin()));
    }
  }

  /*FUNCIONALIDADES*/
  @override
  Widget build(BuildContext context) {
    return Container(
      color: blue,
      child: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Image.asset(
            "lib/assets/logo.png",
          ),
        ),
      ),
    );
  }
}
