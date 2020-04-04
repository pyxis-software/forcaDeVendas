// To parse this JSON data, do
//
//     final venda = vendaFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Venda {
  final int id;
  final String dataVenda;
  final int idEmpresa;
  final int idCliente;
  final String nomeRazao;
  final String clienteCidade;
  final int idVendedor;
  final int idFpagto;
  final int idUsuario;
  final double totBruto;
  final int pedidoStatus;
  final int totDescPrc;
  final double totDescVlr;
  final double totLiquido;
  final String pedidoNfiscal;
  final String pedidoNfiscalEmissao;

  Venda({
    @required this.id,
    @required this.dataVenda,
    @required this.idEmpresa,
    @required this.idCliente,
    @required this.nomeRazao,
    @required this.clienteCidade,
    @required this.idVendedor,
    @required this.idFpagto,
    @required this.idUsuario,
    @required this.totBruto,
    @required this.pedidoStatus,
    @required this.totDescPrc,
    @required this.totDescVlr,
    @required this.totLiquido,
    @required this.pedidoNfiscal,
    @required this.pedidoNfiscalEmissao,
  });

  Venda copyWith({
    int id,
    String dataVenda,
    int idEmpresa,
    int idCliente,
    String nomeRazao,
    String cidade,
    String clienteCidade,
    int idVendedor,
    int idFpagto,
    int idUsuario,
    int totBruto,
    int pedidoStatus,
    int totDescPrc,
    int totDescVlr,
    int totLiquido,
    String pedidoNfiscal,
    String pedidoNfiscalEmissao,
  }) =>
      Venda(
        id: id ?? this.id,
        dataVenda: dataVenda ?? this.dataVenda,
        idEmpresa: idEmpresa ?? this.idEmpresa,
        idCliente: idCliente ?? this.idCliente,
        nomeRazao: nomeRazao ?? this.nomeRazao,
        clienteCidade: clienteCidade ?? this.clienteCidade,
        idVendedor: idVendedor ?? this.idVendedor,
        idFpagto: idFpagto ?? this.idFpagto,
        idUsuario: idUsuario ?? this.idUsuario,
        totBruto: totBruto ?? this.totBruto,
        pedidoStatus: pedidoStatus ?? this.pedidoStatus,
        totDescPrc: totDescPrc ?? this.totDescPrc,
        totDescVlr: totDescVlr ?? this.totDescVlr,
        totLiquido: totLiquido ?? this.totLiquido,
        pedidoNfiscal: pedidoNfiscal ?? this.pedidoNfiscal,
        pedidoNfiscalEmissao: pedidoNfiscalEmissao ?? this.pedidoNfiscalEmissao,
      );

  factory Venda.fromRawJson(String str) => Venda.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Venda.fromJson(Map<String, dynamic> json) => Venda(
    id: json["id"] == null ? null : json["id"],
    dataVenda: json["data_venda"] == null ? null : json["data_venda"],
    idEmpresa: json["id_empresa"] == null ? null : json["id_empresa"],
    idCliente: json["id_cliente"] == null ? null : json["id_cliente"],
    nomeRazao: json["nome_razao"] == null ? null : json["nome_razao"],
    clienteCidade: json["clienteCidade"] == null ? null : json["clienteCidade"],
    idVendedor: json["id_vendedor"] == null ? null : json["id_vendedor"],
    idFpagto: json["id_fpagto"] == null ? null : json["id_fpagto"],
    idUsuario: json["id_usuario"] == null ? null : json["id_usuario"],
    totBruto: json["tot_bruto"] == null ? null : json["tot_bruto"],
    pedidoStatus: json["pedido_status"] == null ? null : json["pedido_status"],
    totDescPrc: json["tot_desc_prc"] == null ? null : json["tot_desc_prc"],
    totDescVlr: json["tot_desc_vlr"] == null ? null : json["tot_desc_vlr"],
    totLiquido: json["tot_liquido"] == null ? null : json["tot_liquido"],
    pedidoNfiscal: json["pedido_nfiscal"] == null ? null : json["pedido_nfiscal"],
    pedidoNfiscalEmissao: json["pedido_nfiscal_emissao"] == null ? null : json["pedido_nfiscal_emissao"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "data_venda": dataVenda == null ? null : dataVenda,
    "id_empresa": idEmpresa == null ? null : idEmpresa,
    "id_cliente": idCliente == null ? null : idCliente,
    "nome_razao": nomeRazao == null ? null : nomeRazao,
    "clienteCidade": clienteCidade == null ? null : clienteCidade,
    "id_vendedor": idVendedor == null ? null : idVendedor,
    "id_fpagto": idFpagto == null ? null : idFpagto,
    "id_usuario": idUsuario == null ? null : idUsuario,
    "tot_bruto": totBruto == null ? null : totBruto,
    "pedido_status": pedidoStatus == null ? null : pedidoStatus,
    "tot_desc_prc": totDescPrc == null ? null : totDescPrc,
    "tot_desc_vlr": totDescVlr == null ? null : totDescVlr,
    "tot_liquido": totLiquido == null ? null : totLiquido,
    "pedido_nfiscal": pedidoNfiscal == null ? null : pedidoNfiscal,
    "pedido_nfiscal_emissao": pedidoNfiscalEmissao == null ? null : pedidoNfiscalEmissao,
  };

  factory Venda.fromMap(Map<String, dynamic> json) => Venda(
    id: json["id"] == null ? null : json["id"],
    dataVenda: json["data_venda"] == null ? null : json["data_venda"],
    idEmpresa: json["id_empresa"] == null ? null : json["id_empresa"],
    idCliente: json["id_cliente"] == null ? null : json["id_cliente"],
    nomeRazao: json["nome_razao"] == null ? null : json["nome_razao"],
    clienteCidade: json["clienteCidade"] == null ? null : json["clienteCidade"],
    idVendedor: json["id_vendedor"] == null ? null : json["id_vendedor"],
    idFpagto: json["id_fpagto"] == null ? null : json["id_fpagto"],
    idUsuario: json["id_usuario"] == null ? null : json["id_usuario"],
    totBruto: json["tot_bruto"] == null ? null : json["tot_bruto"],
    pedidoStatus: json["pedido_status"] == null ? null : json["pedido_status"],
    totDescPrc: json["tot_desc_prc"] == null ? null : json["tot_desc_prc"],
    totDescVlr: json["tot_desc_vlr"] == null ? null : json["tot_desc_vlr"],
    totLiquido: json["tot_liquido"] == null ? null : json["tot_liquido"],
    pedidoNfiscal: json["pedido_nfiscal"] == null ? null : json["pedido_nfiscal"],
    pedidoNfiscalEmissao: json["pedido_nfiscal_emissao"] == null ? null : json["pedido_nfiscal_emissao"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "data_venda": dataVenda == null ? null : dataVenda,
    "id_empresa": idEmpresa == null ? null : idEmpresa,
    "id_cliente": idCliente == null ? null : idCliente,
    "nome_razao": nomeRazao == null ? null : nomeRazao,
    "clienteCidade": clienteCidade == null ? null : clienteCidade,
    "id_vendedor": idVendedor == null ? null : idVendedor,
    "id_fpagto": idFpagto == null ? null : idFpagto,
    "id_usuario": idUsuario == null ? null : idUsuario,
    "tot_bruto": totBruto == null ? null : totBruto,
    "pedido_status": pedidoStatus == null ? null : pedidoStatus,
    "tot_desc_prc": totDescPrc == null ? null : totDescPrc,
    "tot_desc_vlr": totDescVlr == null ? null : totDescVlr,
    "tot_liquido": totLiquido == null ? null : totLiquido,
    "pedido_nfiscal": pedidoNfiscal == null ? null : pedidoNfiscal,
    "pedido_nfiscal_emissao": pedidoNfiscalEmissao == null ? null : pedidoNfiscalEmissao,
  };
}
