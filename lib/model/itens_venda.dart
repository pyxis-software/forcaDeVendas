// To parse this JSON data, do
//
//     final itensVenda = itensVendaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ItensVenda {
    final int item;
    final int idProduto;
    final String complemento;
    final double vlrVendido;
    final int qtde;
    final double totBruto;
    final int vlrDescPrc;
    final int vlrDescVlr;
    final double vlrLiquido;
    final String grade;
    final int idVendedor;

    ItensVenda({
        @required this.item,
        @required this.idProduto,
        @required this.complemento,
        @required this.vlrVendido,
        @required this.qtde,
        @required this.totBruto,
        @required this.vlrDescPrc,
        @required this.vlrDescVlr,
        @required this.vlrLiquido,
        @required this.grade,
        @required this.idVendedor,
    });

    ItensVenda copyWith({
        int item,
        int idProduto,
        String complemento,
        int vlrVendido,
        int qtde,
        int totBruto,
        int vlrDescPrc,
        int vlrDescVlr,
        int vlrLiquido,
        String grade,
        int idVendedor,
    }) => 
        ItensVenda(
            item: item ?? this.item,
            idProduto: idProduto ?? this.idProduto,
            complemento: complemento ?? this.complemento,
            vlrVendido: vlrVendido ?? this.vlrVendido,
            qtde: qtde ?? this.qtde,
            totBruto: totBruto ?? this.totBruto,
            vlrDescPrc: vlrDescPrc ?? this.vlrDescPrc,
            vlrDescVlr: vlrDescVlr ?? this.vlrDescVlr,
            vlrLiquido: vlrLiquido ?? this.vlrLiquido,
            grade: grade ?? this.grade,
            idVendedor: idVendedor ?? this.idVendedor,
        );

    factory ItensVenda.fromRawJson(String str) => ItensVenda.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItensVenda.fromJson(Map<String, dynamic> json) => ItensVenda(
        item: json["item"] == null ? null : json["item"],
        idProduto: json["id_produto"] == null ? null : json["id_produto"],
        complemento: json["complemento"] == null ? null : json["complemento"],
        vlrVendido: json["vlr_vendido"] == null ? null : json["vlr_vendido"],
        qtde: json["qtde"] == null ? null : json["qtde"],
        totBruto: json["tot_bruto"] == null ? null : json["tot_bruto"],
        vlrDescPrc: json["vlr_desc_prc"] == null ? null : json["vlr_desc_prc"],
        vlrDescVlr: json["vlr_desc_vlr"] == null ? null : json["vlr_desc_vlr"],
        vlrLiquido: json["vlr_liquido"] == null ? null : json["vlr_liquido"],
        grade: json["grade"] == null ? null : json["grade"],
        idVendedor: json["id_vendedor"] == null ? null : json["id_vendedor"],
    );

    Map<String, dynamic> toJson() => {
        "item": item == null ? null : item,
        "id_produto": idProduto == null ? null : idProduto,
        "complemento": complemento == null ? null : complemento,
        "vlr_vendido": vlrVendido == null ? null : vlrVendido,
        "qtde": qtde == null ? null : qtde,
        "tot_bruto": totBruto == null ? null : totBruto,
        "vlr_desc_prc": vlrDescPrc == null ? null : vlrDescPrc,
        "vlr_desc_vlr": vlrDescVlr == null ? null : vlrDescVlr,
        "vlr_liquido": vlrLiquido == null ? null : vlrLiquido,
        "grade": grade == null ? null : grade,
        "id_vendedor": idVendedor == null ? null : idVendedor,
    };

    factory ItensVenda.fromMap(Map<String, dynamic> json) => ItensVenda(
        item: json["item"] == null ? null : json["item"],
        idProduto: json["id_produto"] == null ? null : json["id_produto"],
        complemento: json["complemento"] == null ? null : json["complemento"],
        vlrVendido: json["vlr_vendido"] == null ? null : json["vlr_vendido"],
        qtde: json["qtde"] == null ? null : json["qtde"],
        totBruto: json["tot_bruto"] == null ? null : json["tot_bruto"],
        vlrDescPrc: json["vlr_desc_prc"] == null ? null : json["vlr_desc_prc"],
        vlrDescVlr: json["vlr_desc_vlr"] == null ? null : json["vlr_desc_vlr"],
        vlrLiquido: json["vlr_liquido"] == null ? null : json["vlr_liquido"],
        grade: json["grade"] == null ? null : json["grade"],
        idVendedor: json["id_vendedor"] == null ? null : json["id_vendedor"],
    );

    Map<String, dynamic> toMap() => {
        "item": item == null ? null : item,
        "id_produto": idProduto == null ? null : idProduto,
        "complemento": complemento == null ? null : complemento,
        "vlr_vendido": vlrVendido == null ? null : vlrVendido,
        "qtde": qtde == null ? null : qtde,
        "tot_bruto": totBruto == null ? null : totBruto,
        "vlr_desc_prc": vlrDescPrc == null ? null : vlrDescPrc,
        "vlr_desc_vlr": vlrDescVlr == null ? null : vlrDescVlr,
        "vlr_liquido": vlrLiquido == null ? null : vlrLiquido,
        "grade": grade == null ? null : grade,
        "id_vendedor": idVendedor == null ? null : idVendedor,
    };
}
