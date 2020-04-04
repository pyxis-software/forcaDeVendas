// To parse this JSON data, do
//
//     final iten = itenFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Iten {
  final int id;
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
  final String grade;
  final double pvenda;
  final int saldoGeral;
  final String produtoUnidade;
  final int idVenda;
  final int qtdVenda;

  Iten({
    @required this.id,
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
    @required this.idVenda,
    @required this.qtdVenda,
  });

  Iten copyWith({
    int id,
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
    String grupoNome,
    int idSubGrupo,
    String subgrupoNome,
    String idNcm,
    String grade,
    double pvenda,
    int saldoGeral,
    String produtoUnidade,
    int idVenda,
    int qtdVenda,
  }) =>
      Iten(
        id: id ?? this.id,
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
        idVenda: idVenda ?? this.idVenda,
        qtdVenda: qtdVenda ?? this.qtdVenda,
      );

  factory Iten.fromRawJson(String str) => Iten.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Iten.fromJson(Map<String, dynamic> json) => Iten(
    id: json["id"] == null ? null : json["id"],
    idEmpresa: json["id_empresa"] == null ? null : json["id_empresa"],
    idProduto: json["id_produto"] == null ? null : json["id_produto"],
    produtoDescricao: json["produto_descricao"] == null ? null : json["produto_descricao"],
    refFabrica: json["ref_fabrica"] == null ? null : json["ref_fabrica"],
    gtin: json["gtin"] == null ? null : json["gtin"],
    aplicacao: json["aplicacao"] == null ? null : json["aplicacao"],
    peso: json["peso"] == null ? null : json["peso"],
    idFabricante: json["id_fabricante"] == null ? null : json["id_fabricante"],
    fabricanteNome: json["fabricante_nome"] == null ? null : json["fabricante_nome"],
    idGrupo: json["id_grupo"] == null ? null : json["id_grupo"],
    grupoNome: json["grupo_nome"] == null ? null : json["grupo_nome"],
    idSubGrupo: json["id_sub_grupo"] == null ? null : json["id_sub_grupo"],
    subgrupoNome: json["subgrupo_nome"] == null ? null : json["subgrupo_nome"],
    idNcm: json["id_ncm"] == null ? null : json["id_ncm"],
    grade: json["grade"] == null ? null : json["grade"],
    pvenda: json["pvenda"] == null ? null : json["pvenda"].toDouble(),
    saldoGeral: json["saldo_geral"] == null ? null : json["saldo_geral"],
    produtoUnidade: json["produto_unidade"] == null ? null : json["produto_unidade"],
    idVenda: json["id_venda"] == null ? null : json["id_venda"],
    qtdVenda: json["qtd_venda"] == null ? null : json["qtd_venda"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "id_empresa": idEmpresa == null ? null : idEmpresa,
    "id_produto": idProduto == null ? null : idProduto,
    "produto_descricao": produtoDescricao == null ? null : produtoDescricao,
    "ref_fabrica": refFabrica == null ? null : refFabrica,
    "gtin": gtin == null ? null : gtin,
    "aplicacao": aplicacao == null ? null : aplicacao,
    "peso": peso == null ? null : peso,
    "id_fabricante": idFabricante == null ? null : idFabricante,
    "fabricante_nome": fabricanteNome == null ? null : fabricanteNome,
    "id_grupo": idGrupo == null ? null : idGrupo,
    "grupo_nome": grupoNome == null ? null : grupoNome,
    "id_sub_grupo": idSubGrupo == null ? null : idSubGrupo,
    "subgrupo_nome": subgrupoNome == null ? null : subgrupoNome,
    "id_ncm": idNcm == null ? null : idNcm,
    "grade": grade == null ? null : grade,
    "pvenda": pvenda == null ? null : pvenda,
    "saldo_geral": saldoGeral == null ? null : saldoGeral,
    "produto_unidade": produtoUnidade == null ? null : produtoUnidade,
    "id_venda": idVenda == null ? null : idVenda,
    "qtd_venda": qtdVenda == null ? null : qtdVenda,
  };

  factory Iten.fromMap(Map<String, dynamic> json) => Iten(
    id: json["id"] == null ? null : json["id"],
    idEmpresa: json["id_empresa"] == null ? null : json["id_empresa"],
    idProduto: json["id_produto"] == null ? null : json["id_produto"],
    produtoDescricao: json["produto_descricao"] == null ? null : json["produto_descricao"],
    refFabrica: json["ref_fabrica"] == null ? null : json["ref_fabrica"],
    gtin: json["gtin"] == null ? null : json["gtin"],
    aplicacao: json["aplicacao"] == null ? null : json["aplicacao"],
    peso: json["peso"] == null ? null : json["peso"],
    idFabricante: json["id_fabricante"] == null ? null : json["id_fabricante"],
    fabricanteNome: json["fabricante_nome"] == null ? null : json["fabricante_nome"],
    idGrupo: json["id_grupo"] == null ? null : json["id_grupo"],
    grupoNome: json["grupo_nome"] == null ? null : json["grupo_nome"],
    idSubGrupo: json["id_sub_grupo"] == null ? null : json["id_sub_grupo"],
    subgrupoNome: json["subgrupo_nome"] == null ? null : json["subgrupo_nome"],
    idNcm: json["id_ncm"] == null ? null : json["id_ncm"],
    grade: json["grade"] == null ? null : json["grade"],
    pvenda: json["pvenda"] == null ? null : json["pvenda"].toDouble(),
    saldoGeral: json["saldo_geral"] == null ? null : json["saldo_geral"],
    produtoUnidade: json["produto_unidade"] == null ? null : json["produto_unidade"],
    idVenda: json["id_venda"] == null ? null : json["id_venda"],
    qtdVenda: json["qtd_venda"] == null ? null : json["qtd_venda"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "id_empresa": idEmpresa == null ? null : idEmpresa,
    "id_produto": idProduto == null ? null : idProduto,
    "produto_descricao": produtoDescricao == null ? null : produtoDescricao,
    "ref_fabrica": refFabrica == null ? null : refFabrica,
    "gtin": gtin == null ? null : gtin,
    "aplicacao": aplicacao == null ? null : aplicacao,
    "peso": peso == null ? null : peso,
    "id_fabricante": idFabricante == null ? null : idFabricante,
    "fabricante_nome": fabricanteNome == null ? null : fabricanteNome,
    "id_grupo": idGrupo == null ? null : idGrupo,
    "grupo_nome": grupoNome == null ? null : grupoNome,
    "id_sub_grupo": idSubGrupo == null ? null : idSubGrupo,
    "subgrupo_nome": subgrupoNome == null ? null : subgrupoNome,
    "id_ncm": idNcm == null ? null : idNcm,
    "grade": grade == null ? null : grade,
    "pvenda": pvenda == null ? null : pvenda,
    "saldo_geral": saldoGeral == null ? null : saldoGeral,
    "produto_unidade": produtoUnidade == null ? null : produtoUnidade,
    "id_venda": idVenda == null ? null : idVenda,
    "qtd_venda": qtdVenda == null ? null : qtdVenda,
  };
}
