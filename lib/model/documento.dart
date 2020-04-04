// To parse this JSON data, do
//
//     final documento = documentoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Documento {
  final int id;
  final int idCliente;
  final int idVenda;
  final String dataVecto;
  final double valorDoc;
  final int parcNum;
  final int parcQtd;

  Documento({
    @required this.id,
    @required this.idCliente,
    @required this.idVenda,
    @required this.dataVecto,
    @required this.valorDoc,
    @required this.parcNum,
    @required this.parcQtd,
  });

  Documento copyWith({
    int id,
    int idCliente,
    int idVenda,
    String dataVecto,
    double valorDoc,
    int parcNum,
    int parcQtd,
  }) =>
      Documento(
        id: id ?? this.id,
        idCliente: idCliente ?? this.idCliente,
        idVenda: idVenda ?? this.idVenda,
        dataVecto: dataVecto ?? this.dataVecto,
        valorDoc: valorDoc ?? this.valorDoc,
        parcNum: parcNum ?? this.parcNum,
        parcQtd: parcQtd ?? this.parcQtd,
      );

  factory Documento.fromRawJson(String str) => Documento.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Documento.fromJson(Map<String, dynamic> json) => Documento(
    id: json["id"] == null ? null : json["id"],
    idCliente: json["id_cliente"] == null ? null : json["id_cliente"],
    idVenda: json["id_venda"] == null ? null : json["id_venda"],
    dataVecto: json["data_vecto"] == null ? null : json["data_vecto"],
    valorDoc: json["valor_doc"] == null ? null : json["valor_doc"].toDouble(),
    parcNum: json["parc_num"] == null ? null : json["parc_num"],
    parcQtd: json["parc_qtd"] == null ? null : json["parc_qtd"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "id_cliente": idCliente == null ? null : idCliente,
    "id_venda": idVenda == null ? null : idVenda,
    "data_vecto": dataVecto == null ? null : dataVecto,
    "valor_doc": valorDoc == null ? null : valorDoc,
    "parc_num": parcNum == null ? null : parcNum,
    "parc_qtd": parcQtd == null ? null : parcQtd,
  };

  factory Documento.fromMap(Map<String, dynamic> json) => Documento(
    id: json["id"] == null ? null : json["id"],
    idCliente: json["id_cliente"] == null ? null : json["id_cliente"],
    idVenda: json["id_venda"] == null ? null : json["id_venda"],
    dataVecto: json["data_vecto"] == null ? null : json["data_vecto"],
    valorDoc: json["valor_doc"] == null ? null : json["valor_doc"].toDouble(),
    parcNum: json["parc_num"] == null ? null : json["parc_num"],
    parcQtd: json["parc_qtd"] == null ? null : json["parc_qtd"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "id_cliente": idCliente == null ? null : idCliente,
    "id_venda": idVenda == null ? null : idVenda,
    "data_vecto": dataVecto == null ? null : dataVecto,
    "valor_doc": valorDoc == null ? null : valorDoc,
    "parc_num": parcNum == null ? null : parcNum,
    "parc_qtd": parcQtd == null ? null : parcQtd,
  };
}
