// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Cliente {
    final int id;
    final int tpPessoa;
    final String cpfCnpj;
    final String nomeRazao;
    final String apelidoFantasia;
    final String rgInsc;
    final dynamic inscMunicipal;
    final dynamic fone1;
    final String fone2;
    final dynamic fone3;
    final String cep;
    final String endereco;
    final dynamic enderecoNumero;
    final dynamic complemento;
    final String bairro;
    final int idMunicipio;
    final int idStatus;
    final int idClienteTipo;
    final int limiteCredito;
    final double totalPendente;
    final double limiteDisponivel;

    Cliente({
        @required this.id,
        @required this.tpPessoa,
        @required this.cpfCnpj,
        @required this.nomeRazao,
        @required this.apelidoFantasia,
        @required this.rgInsc,
        @required this.inscMunicipal,
        @required this.fone1,
        @required this.fone2,
        @required this.fone3,
        @required this.cep,
        @required this.endereco,
        @required this.enderecoNumero,
        @required this.complemento,
        @required this.bairro,
        @required this.idMunicipio,
        @required this.idStatus,
        @required this.idClienteTipo,
        @required this.limiteCredito,
        @required this.totalPendente,
        @required this.limiteDisponivel,
    });

    Cliente copyWith({
        int id,
        int tpPessoa,
        String cpfCnpj,
        String nomeRazao,
        String apelidoFantasia,
        String rgInsc,
        dynamic inscMunicipal,
        dynamic fone1,
        String fone2,
        dynamic fone3,
        String cep,
        String endereco,
        dynamic enderecoNumero,
        dynamic complemento,
        String bairro,
        int idMunicipio,
        int idStatus,
        int idClienteTipo,
        int limiteCredito,
        double totalPendente,
        double limiteDisponivel,
    }) =>
        Cliente(
            id: id ?? this.id,
            tpPessoa: tpPessoa ?? this.tpPessoa,
            cpfCnpj: cpfCnpj ?? this.cpfCnpj,
            nomeRazao: nomeRazao ?? this.nomeRazao,
            apelidoFantasia: apelidoFantasia ?? this.apelidoFantasia,
            rgInsc: rgInsc ?? this.rgInsc,
            inscMunicipal: inscMunicipal ?? this.inscMunicipal,
            fone1: fone1 ?? this.fone1,
            fone2: fone2 ?? this.fone2,
            fone3: fone3 ?? this.fone3,
            cep: cep ?? this.cep,
            endereco: endereco ?? this.endereco,
            enderecoNumero: enderecoNumero ?? this.enderecoNumero,
            complemento: complemento ?? this.complemento,
            bairro: bairro ?? this.bairro,
            idMunicipio: idMunicipio ?? this.idMunicipio,
            idStatus: idStatus ?? this.idStatus,
            idClienteTipo: idClienteTipo ?? this.idClienteTipo,
            limiteCredito: limiteCredito ?? this.limiteCredito,
            totalPendente: totalPendente ?? this.totalPendente,
            limiteDisponivel: limiteDisponivel ?? this.limiteDisponivel,
        );

    factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"] == null ? null : json["id"],
        tpPessoa: json["tp_pessoa"] == null ? null : json["tp_pessoa"],
        cpfCnpj: json["cpf_cnpj"] == null ? null : json["cpf_cnpj"],
        nomeRazao: json["nome_razao"] == null ? null : json["nome_razao"],
        apelidoFantasia: json["apelido_fantasia"] == null ? null : json["apelido_fantasia"],
        rgInsc: json["rg_insc"] == null ? null : json["rg_insc"],
        inscMunicipal: json["insc_municipal"],
        fone1: json["fone1"],
        fone2: json["fone2"] == null ? null : json["fone2"],
        fone3: json["fone3"],
        cep: json["cep"] == null ? null : json["cep"],
        endereco: json["endereco"] == null ? null : json["endereco"],
        enderecoNumero: json["endereco_numero"],
        complemento: json["complemento"],
        bairro: json["bairro"] == null ? null : json["bairro"],
        idMunicipio: json["id_municipio"] == null ? null : json["id_municipio"],
        idStatus: json["id_status"] == null ? null : json["id_status"],
        idClienteTipo: json["id_cliente_tipo"] == null ? null : json["id_cliente_tipo"],
        limiteCredito: json["limite_credito"] == null ? null : json["limite_credito"],
        totalPendente: json["total_pendente"] == null ? null : json["total_pendente"].toDouble(),
        limiteDisponivel: json["limite_disponivel"] == null ? null : json["limite_disponivel"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tp_pessoa": tpPessoa == null ? null : tpPessoa,
        "cpf_cnpj": cpfCnpj == null ? null : cpfCnpj,
        "nome_razao": nomeRazao == null ? null : nomeRazao,
        "apelido_fantasia": apelidoFantasia == null ? null : apelidoFantasia,
        "rg_insc": rgInsc == null ? null : rgInsc,
        "insc_municipal": inscMunicipal,
        "fone1": fone1,
        "fone2": fone2 == null ? null : fone2,
        "fone3": fone3,
        "cep": cep == null ? null : cep,
        "endereco": endereco == null ? null : endereco,
        "endereco_numero": enderecoNumero,
        "complemento": complemento,
        "bairro": bairro == null ? null : bairro,
        "id_municipio": idMunicipio == null ? null : idMunicipio,
        "id_status": idStatus == null ? null : idStatus,
        "id_cliente_tipo": idClienteTipo == null ? null : idClienteTipo,
        "limite_credito": limiteCredito == null ? null : limiteCredito,
        "total_pendente": totalPendente == null ? null : totalPendente,
        "limite_disponivel": limiteDisponivel == null ? null : limiteDisponivel,
    };

    factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"] == null ? null : json["id"],
        tpPessoa: json["tp_pessoa"] == null ? null : json["tp_pessoa"],
        cpfCnpj: json["cpf_cnpj"] == null ? null : json["cpf_cnpj"],
        nomeRazao: json["nome_razao"] == null ? null : json["nome_razao"],
        apelidoFantasia: json["apelido_fantasia"] == null ? null : json["apelido_fantasia"],
        rgInsc: json["rg_insc"] == null ? null : json["rg_insc"],
        inscMunicipal: json["insc_municipal"],
        fone1: json["fone1"],
        fone2: json["fone2"] == null ? null : json["fone2"],
        fone3: json["fone3"],
        cep: json["cep"] == null ? null : json["cep"],
        endereco: json["endereco"] == null ? null : json["endereco"],
        enderecoNumero: json["endereco_numero"],
        complemento: json["complemento"],
        bairro: json["bairro"] == null ? null : json["bairro"],
        idMunicipio: json["id_municipio"] == null ? null : json["id_municipio"],
        idStatus: json["id_status"] == null ? null : json["id_status"],
        idClienteTipo: json["id_cliente_tipo"] == null ? null : json["id_cliente_tipo"],
        limiteCredito: json["limite_credito"] == null ? null : json["limite_credito"],
        totalPendente: json["total_pendente"] == null ? null : json["total_pendente"].toDouble(),
        limiteDisponivel: json["limite_disponivel"] == null ? null : json["limite_disponivel"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "tp_pessoa": tpPessoa == null ? null : tpPessoa,
        "cpf_cnpj": cpfCnpj == null ? null : cpfCnpj,
        "nome_razao": nomeRazao == null ? null : nomeRazao,
        "apelido_fantasia": apelidoFantasia == null ? null : apelidoFantasia,
        "rg_insc": rgInsc == null ? null : rgInsc,
        "insc_municipal": inscMunicipal,
        "fone1": fone1,
        "fone2": fone2 == null ? null : fone2,
        "fone3": fone3,
        "cep": cep == null ? null : cep,
        "endereco": endereco == null ? null : endereco,
        "endereco_numero": enderecoNumero,
        "complemento": complemento,
        "bairro": bairro == null ? null : bairro,
        "id_municipio": idMunicipio == null ? null : idMunicipio,
        "id_status": idStatus == null ? null : idStatus,
        "id_cliente_tipo": idClienteTipo == null ? null : idClienteTipo,
        "limite_credito": limiteCredito == null ? null : limiteCredito,
        "total_pendente": totalPendente == null ? null : totalPendente,
        "limite_disponivel": limiteDisponivel == null ? null : limiteDisponivel,
    };
}
