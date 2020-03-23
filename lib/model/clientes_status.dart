// To parse this JSON data, do
//
//     final clienteStatus = clienteStatusFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ClienteStatus clienteStatusFromJson(String str) => ClienteStatus.fromJson(json.decode(str));

String clienteStatusToJson(ClienteStatus data) => json.encode(data.toJson());

class ClienteStatus {
    final int id;
    final String descricao;
    final int bloquePessoa;

    ClienteStatus({
        @required this.id,
        @required this.descricao,
        @required this.bloquePessoa,
    });

    ClienteStatus copyWith({
        int id,
        String descricao,
        int bloquePessoa,
    }) => 
        ClienteStatus(
            id: id ?? this.id,
            descricao: descricao ?? this.descricao,
            bloquePessoa: bloquePessoa ?? this.bloquePessoa,
        );

    factory ClienteStatus.fromJson(Map<String, dynamic> json) => ClienteStatus(
        id: json["id"],
        descricao: json["descricao"],
        bloquePessoa: json["bloque_pessoa"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "bloque_pessoa": bloquePessoa,
    };

    factory ClienteStatus.fromMap(Map<String, dynamic> json) => ClienteStatus(
        id: json["id"],
        descricao: json["descricao"],
        bloquePessoa: json["bloque_pessoa"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "descricao": descricao,
        "bloque_pessoa": bloquePessoa,
    };
}