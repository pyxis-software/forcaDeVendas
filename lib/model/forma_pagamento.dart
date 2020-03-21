// To parse this JSON data, do
//
//     final formaPagamento = formaPagamentoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class FormaPagamento {
  final int id;
  final String descricao;
  final int qtdadeParc;
  final int status;

  FormaPagamento({
    @required this.id,
    @required this.descricao,
    @required this.qtdadeParc,
    @required this.status,
  });

  FormaPagamento copyWith({
    int id,
    String descricao,
    int qtdadeParc,
    int status,
  }) =>
      FormaPagamento(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        qtdadeParc: qtdadeParc ?? this.qtdadeParc,
        status: status ?? this.status,
      );

  factory FormaPagamento.fromRawJson(String str) => FormaPagamento.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FormaPagamento.fromJson(Map<String, dynamic> json) => FormaPagamento(
    id: json["id"] == null ? null : json["id"],
    descricao: json["descricao"] == null ? null : json["descricao"],
    qtdadeParc: json["qtdade_parc"] == null ? null : json["qtdade_parc"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "descricao": descricao == null ? null : descricao,
    "qtdade_parc": qtdadeParc == null ? null : qtdadeParc,
    "status": status == null ? null : status,
  };

  factory FormaPagamento.fromMap(Map<String, dynamic> json) => FormaPagamento(
    id: json["id"] == null ? null : json["id"],
    descricao: json["descricao"] == null ? null : json["descricao"],
    qtdadeParc: json["qtdade_parc"] == null ? null : json["qtdade_parc"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "descricao": descricao == null ? null : descricao,
    "qtdade_parc": qtdadeParc == null ? null : qtdadeParc,
    "status": status == null ? null : status,
  };
}
