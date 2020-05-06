// To parse this JSON data, do
//
//     final resultPedido = resultPedidoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ResultPedido {
    final String result;

    ResultPedido({
        @required this.result,
    });

    ResultPedido copyWith({
        String result,
    }) => 
        ResultPedido(
            result: result ?? this.result,
        );

    factory ResultPedido.fromRawJson(String str) => ResultPedido.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResultPedido.fromJson(Map<String, dynamic> json) => ResultPedido(
        result: json["result"] == null ? null : json["result"],
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
    };

    factory ResultPedido.fromMap(Map<String, dynamic> json) => ResultPedido(
        result: json["result"] == null ? null : json["result"],
    );

    Map<String, dynamic> toMap() => {
        "result": result == null ? null : result,
    };
}
