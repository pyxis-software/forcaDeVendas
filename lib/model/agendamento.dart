// To parse this JSON data, do
//
//     final agendamento = agendamentoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Agendamento {
    final int id;
    final int idPessoa;
    final String nomeCliente;
    final int idVendedor;
    final String data;
    final String observacao;
    final int visitou;

    Agendamento({
        @required this.id,
        @required this.idPessoa,
        @required this.nomeCliente,
        @required this.idVendedor,
        @required this.data,
        @required this.observacao,
        @required this.visitou,
    });

    Agendamento copyWith({
        int id,
        int idPessoa,
        String nomeCliente,
        int idVendedor,
        String data,
        String observacao,
        int visitou,
    }) => 
        Agendamento(
            id: id ?? this.id,
            idPessoa: idPessoa ?? this.idPessoa,
            nomeCliente: nomeCliente ?? this.nomeCliente,
            idVendedor: idVendedor ?? this.idVendedor,
            data: data ?? this.data,
            observacao: observacao ?? this.observacao,
            visitou: visitou ?? this.visitou,
        );

    factory Agendamento.fromRawJson(String str) => Agendamento.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Agendamento.fromJson(Map<String, dynamic> json) => Agendamento(
        id: json["id"] == null ? null : json["id"],
        idPessoa: json["id_pessoa"] == null ? null : json["id_pessoa"],
        nomeCliente: json["nome_cliente"] == null ? null : json["nome_cliente"],
        idVendedor: json["id_vendedor"] == null ? null : json["id_vendedor"],
        data: json["data"] == null ? null : json["data"],
        observacao: json["observacao"] == null ? null : json["observacao"],
        visitou: json["visitou"] == null ? null : json["visitou"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_pessoa": idPessoa == null ? null : idPessoa,
        "nome_cliente": nomeCliente == null ? null : nomeCliente,
        "id_vendedor": idVendedor == null ? null : idVendedor,
        "data": data == null ? null : data,
        "observacao": observacao == null ? null : observacao,
        "visitou": visitou == null ? null : visitou,
    };

    factory Agendamento.fromMap(Map<String, dynamic> json) => Agendamento(
        id: json["id"] == null ? null : json["id"],
        idPessoa: json["id_pessoa"] == null ? null : json["id_pessoa"],
        nomeCliente: json["nome_cliente"] == null ? null : json["nome_cliente"],
        idVendedor: json["id_vendedor"] == null ? null : json["id_vendedor"],
        data: json["data"] == null ? null : json["data"],
        observacao: json["observacao"] == null ? null : json["observacao"],
        visitou: json["visitou"] == null ? null : json["visitou"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "id_pessoa": idPessoa == null ? null : idPessoa,
        "nome_cliente": nomeCliente == null ? null : nomeCliente,
        "id_vendedor": idVendedor == null ? null : idVendedor,
        "data": data == null ? null : data,
        "observacao": observacao == null ? null : observacao,
        "visitou": visitou == null ? null : visitou,
    };
}
