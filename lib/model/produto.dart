// To parse this JSON data, do
//
//     final produto = produtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Produto> produtoFromJson(String str) => List<Produto>.from(json.decode(str).map((x) => Produto.fromJson(x)));

String produtoToJson(List<Produto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Produto {
    final int idEmpresa;
    final int idProduto;
    final String produtoDescricao;
    final String refFabrica;
    final String gtin;
    final String aplicacao;
    final int peso;
    final int idFabricante;
    final String fabricanteNome;
    final int idGrupo;
    final String grupoNome;
    final int idSubGrupo;
    final String subgrupoNome;
    final String idNcm;
    final Ade grade;
    final double pvenda;
    final double saldoGeral;
    final Ade produtoUnidade;

    Produto({
        @required this.idEmpresa,
        @required this.idProduto,
        @required this.produtoDescricao,
        @required this.refFabrica,
        @required this.gtin,
        @required this.aplicacao,
        @required this.peso,
        @required this.idFabricante,
        @required this.fabricanteNome,
        @required this.idGrupo,
        @required this.grupoNome,
        @required this.idSubGrupo,
        @required this.subgrupoNome,
        @required this.idNcm,
        @required this.grade,
        @required this.pvenda,
        @required this.saldoGeral,
        @required this.produtoUnidade,
    });

    Produto copyWith({
        int idEmpresa,
        int idProduto,
        String produtoDescricao,
        String refFabrica,
        String gtin,
        String aplicacao,
        int peso,
        int idFabricante,
        String fabricanteNome,
        int idGrupo,
        GrupoNome grupoNome,
        int idSubGrupo,
        GrupoNome subgrupoNome,
        String idNcm,
        Ade grade,
        double pvenda,
        double saldoGeral,
        Ade produtoUnidade,
    }) => 
        Produto(
            idEmpresa: idEmpresa ?? this.idEmpresa,
            idProduto: idProduto ?? this.idProduto,
            produtoDescricao: produtoDescricao ?? this.produtoDescricao,
            refFabrica: refFabrica ?? this.refFabrica,
            gtin: gtin ?? this.gtin,
            aplicacao: aplicacao ?? this.aplicacao,
            peso: peso ?? this.peso,
            idFabricante: idFabricante ?? this.idFabricante,
            fabricanteNome: fabricanteNome ?? this.fabricanteNome,
            idGrupo: idGrupo ?? this.idGrupo,
            grupoNome: grupoNome ?? this.grupoNome,
            idSubGrupo: idSubGrupo ?? this.idSubGrupo,
            subgrupoNome: subgrupoNome ?? this.subgrupoNome,
            idNcm: idNcm ?? this.idNcm,
            grade: grade ?? this.grade,
            pvenda: pvenda ?? this.pvenda,
            saldoGeral: saldoGeral ?? this.saldoGeral,
            produtoUnidade: produtoUnidade ?? this.produtoUnidade,
        );

    factory Produto.fromJson(Map<String, dynamic> json) => Produto(
        idEmpresa: json["id_empresa"],
        idProduto: json["id_produto"],
        produtoDescricao: json["produto_descricao"],
        refFabrica: json["ref_fabrica"],
        gtin: json["gtin"],
        aplicacao: json["aplicacao"],
        peso: json["peso"],
        idFabricante: json["id_fabricante"],
        fabricanteNome: json["fabricante_nome"],
        idGrupo: json["id_grupo"],
        grupoNome: json["grupo_nome"],
        idSubGrupo: json["id_sub_grupo"],
        subgrupoNome: json["subgrupo_nome"],
        idNcm: json["id_ncm"],
        grade: adeValues.map[json["grade"]],
        pvenda: json["pvenda"].toDouble(),
        saldoGeral: json["saldo_geral"].toDouble(),
        produtoUnidade: adeValues.map[json["produto_unidade"]],
    );

    Map<String, dynamic> toJson() => {
        "id_empresa": idEmpresa,
        "id_produto": idProduto,
        "produto_descricao": produtoDescricao,
        "ref_fabrica": refFabrica,
        "gtin": gtin,
        "aplicacao": aplicacao,
        "peso": peso,
        "id_fabricante": idFabricante,
        "fabricante_nome": fabricanteNome,
        "id_grupo": idGrupo,
        "grupo_nome": grupoNome,
        "id_sub_grupo": idSubGrupo,
        "subgrupo_nome": subgrupoNome,
        "id_ncm": idNcm,
        "grade": adeValues.reverse[grade],
        "pvenda": pvenda,
        "saldo_geral": saldoGeral,
        "produto_unidade": adeValues.reverse[produtoUnidade],
    };
    Map<String, dynamic> toMap() => {
        "id_empresa": idEmpresa,
        "id_produto": idProduto,
        "produto_descricao": produtoDescricao,
        "ref_fabrica": refFabrica,
        "gtin": gtin,
        "aplicacao": aplicacao,
        "peso": peso,
        "id_fabricante": idFabricante,
        "fabricante_nome": fabricanteNome,
        "id_grupo": idGrupo,
        "grupo_nome": grupoNome,
        "id_sub_grupo": idSubGrupo,
        "subgrupo_nome": subgrupoNome,
        "id_ncm": idNcm,
        "grade": adeValues.reverse[grade],
        "pvenda": pvenda,
        "saldo_geral": saldoGeral,
        "produto_unidade": adeValues.reverse[produtoUnidade],
    };
}

enum Ade { UN, KG, CX }

final adeValues = EnumValues({
    "CX": Ade.CX,
    "KG": Ade.KG,
    "UN": Ade.UN
});

enum GrupoNome { COMODATOS, PADRAO, CERVEJAS_ESPECIAIS, CARNES }

final grupoNomeValues = EnumValues({
    "CARNES": GrupoNome.CARNES,
    "CERVEJAS ESPECIAIS": GrupoNome.CERVEJAS_ESPECIAIS,
    "COMODATOS": GrupoNome.COMODATOS,
    "PADRAO": GrupoNome.PADRAO
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
