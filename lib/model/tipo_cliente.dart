// To parse this JSON data, do
//
//     final tipoCliente = tipoClienteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TipoCliente {
  final int id;
  final String descricao;
  final int status;

  TipoCliente({
    @required this.id,
    @required this.descricao,
    @required this.status,
  });

  TipoCliente copyWith({
    int id,
    String descricao,
    int status,
  }) =>
      TipoCliente(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        status: status ?? this.status,
      );

  factory TipoCliente.fromRawJson(String str) => TipoCliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TipoCliente.fromJson(Map<String, dynamic> json) => TipoCliente(
    id: json["id"] == null ? null : json["id"],
    descricao: json["descricao"] == null ? null : json["descricao"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "descricao": descricao == null ? null : descricao,
    "status": status == null ? null : status,
  };
  factory TipoCliente.fromMap(Map<String, dynamic> json) => TipoCliente(
    id: json["id"] == null ? null : json["id"],
    descricao: json["descricao"] == null ? null : json["descricao"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "descricao": descricao == null ? null : descricao,
    "status": status == null ? null : status,
  };
}
