// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Pedido> clienteFromJson(String str) => List<Pedido>.from(json.decode(str).map((x) => Pedido.fromJson(x)));

String clienteToJson(List<Pedido> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pedido {
    final int codigo;
    final String nome;
    final String cidade;
    final String data;
    final double valor;

    Pedido({
        @required this.codigo,
        @required this.nome,
        @required this.cidade,
        @required this.data,
        @required this.valor,
    });

    Pedido copyWith({
        int codigo,
        String nome,
        String cidade,
        String data,
        double valor,
    }) => 
        Pedido(
            codigo: codigo ?? this.codigo,
            nome: nome ?? this.nome,
            cidade: cidade ?? this.cidade,
            data: data ?? this.data,
            valor: valor ?? this.valor,
        );

    factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        codigo: json["codigo"],
        nome: json["nome"],
        cidade: json["cidade"],
        data: json["data"],
        valor: json["valor"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nome": nome,
        "cidade": cidade,
        "data": data,
        "valor": valor,
    };
}
