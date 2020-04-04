import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_de_vendas/view/TelaInicial.dart';
import 'package:forca_de_vendas/view/TelaLogin.dart';
import 'package:forca_de_vendas/view/TelaSplash.dart';
import 'package:forca_de_vendas/view/Telaconfiguracao.dart';
import 'package:forca_de_vendas/view/sincronizar_dados.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        '/inicio': (context) => TelaInicial(),
      },
    );
  }
}