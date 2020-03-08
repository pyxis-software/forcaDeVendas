import 'package:flutter/material.dart';
import 'package:forca_de_vendas/view/TelaSplash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winsac Data Collector',
      debugShowCheckedModeBanner: false,
      home: TelaSplash()
    );
  }
}