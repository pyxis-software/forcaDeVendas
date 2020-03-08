// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Cliente> clienteFromJson(String str) => List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));

String clienteToJson(List<Cliente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cliente {
    final int codigo;
    final String nome;
    final String cidade;
    final String data;
    final double valor;

    Cliente({
        @required this.codigo,
        @required this.nome,
        @required this.cidade,
        @required this.data,
        @required this.valor,
    });

    Cliente copyWith({
        int codigo,
        String nome,
        String cidade,
        String data,
        double valor,
    }) => 
        Cliente(
            codigo: codigo ?? this.codigo,
            nome: nome ?? this.nome,
            cidade: cidade ?? this.cidade,
            data: data ?? this.data,
            valor: valor ?? this.valor,
        );

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
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
