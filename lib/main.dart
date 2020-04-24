import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/view/configracao_page.dart';
import 'package:forca_de_vendas/view/login_page.dart';
import 'package:forca_de_vendas/view/sincronizar_dados_page.dart';
import 'package:forca_de_vendas/view/splash_page.dart';
import 'package:forca_de_vendas/view/tela_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //definindo a rotação do aplicativo
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: 'Força de Vendas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //theme: ThemeData(fontFamily: 'ModernSans'),
      routes: <String, WidgetBuilder>{
        '/': (context) => TelaSplash(),
        '/login': (context) => TelaLogin(),
        '/sincronismo': (context) => SincronizarDados(),
        '/configuracao': (context) => TelaConfiguracao(),
        '/inicio': (context) => TelaHome(),
      },
    );
  }
}
