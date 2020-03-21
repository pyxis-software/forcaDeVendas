// To parse this JSON data, do
//
//     final mensagem = mensagemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Mensagem {
  final String message;
  final String result;

  Mensagem({
    @required this.message,
    @required this.result,
  });

  Mensagem copyWith({
    String message,
    String result,
  }) =>
      Mensagem(
        message: message ?? this.message,
        result: result ?? this.result,
      );

  factory Mensagem.fromRawJson(String str) => Mensagem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Mensagem.fromJson(Map<String, dynamic> json) => Mensagem(
    message: json["MESSAGE"] == null ? null : json["MESSAGE"],
    result: json["RESULT"] == null ? null : json["RESULT"],
  );

  Map<String, dynamic> toJson() => {
    "MESSAGE": message == null ? null : message,
    "RESULT": result == null ? null : result,
  };
}
