// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

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
        );

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        tpPessoa: json["tp_pessoa"],
        cpfCnpj: json["cpf_cnpj"],
        nomeRazao: json["nome_razao"],
        apelidoFantasia: json["apelido_fantasia"],
        rgInsc: json["rg_insc"],
        inscMunicipal: json["insc_municipal"],
        fone1: json["fone1"],
        fone2: json["fone2"],
        fone3: json["fone3"],
        cep: json["cep"],
        endereco: json["endereco"],
        enderecoNumero: json["endereco_numero"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        idMunicipio: json["id_municipio"],
        idStatus: json["id_status"],
        idClienteTipo: json["id_cliente_tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tp_pessoa": tpPessoa,
        "cpf_cnpj": cpfCnpj,
        "nome_razao": nomeRazao,
        "apelido_fantasia": apelidoFantasia,
        "rg_insc": rgInsc,
        "insc_municipal": inscMunicipal,
        "fone1": fone1,
        "fone2": fone2,
        "fone3": fone3,
        "cep": cep,
        "endereco": endereco,
        "endereco_numero": enderecoNumero,
        "complemento": complemento,
        "bairro": bairro,
        "id_municipio": idMunicipio,
        "id_status": idStatus,
        "id_cliente_tipo": idClienteTipo,
    };

    factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        tpPessoa: json["tp_pessoa"],
        cpfCnpj: json["cpf_cnpj"],
        nomeRazao: json["nome_razao"],
        apelidoFantasia: json["apelido_fantasia"],
        rgInsc: json["rg_insc"],
        inscMunicipal: json["insc_municipal"],
        fone1: json["fone1"],
        fone2: json["fone2"],
        fone3: json["fone3"],
        cep: json["cep"],
        endereco: json["endereco"],
        enderecoNumero: json["endereco_numero"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        idMunicipio: json["id_municipio"],
        idStatus: json["id_status"],
        idClienteTipo: json["id_cliente_tipo"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "tp_pessoa": tpPessoa,
        "cpf_cnpj": cpfCnpj,
        "nome_razao": nomeRazao,
        "apelido_fantasia": apelidoFantasia,
        "rg_insc": rgInsc,
        "insc_municipal": inscMunicipal,
        "fone1": fone1,
        "fone2": fone2,
        "fone3": fone3,
        "cep": cep,
        "endereco": endereco,
        "endereco_numero": enderecoNumero,
        "complemento": complemento,
        "bairro": bairro,
        "id_municipio": idMunicipio,
        "id_status": idStatus,
        "id_cliente_tipo": idClienteTipo,
    };
}
