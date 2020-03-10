// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    final int codigo;
    final String cpf;
    final String nome;
    final String endereco;
    final String bairro;
    final String cidade;
    final String estado;
    final String cep;
    final String telefone;
    final String celular;

    Cliente({
        @required this.codigo,
        @required this.cpf,
        @required this.nome,
        @required this.endereco,
        @required this.bairro,
        @required this.cidade,
        @required this.estado,
        @required this.cep,
        @required this.telefone,
        @required this.celular,
    });

    Cliente copyWith({
        int codigo,
        String cpf,
        String nome,
        String endereco,
        String bairro,
        String cidade,
        String estado,
        String cep,
        String telefone,
        String celular,
    }) => 
        Cliente(
            codigo: codigo ?? this.codigo,
            cpf: cpf ?? this.cpf,
            nome: nome ?? this.nome,
            endereco: endereco ?? this.endereco,
            bairro: bairro ?? this.bairro,
            cidade: cidade ?? this.cidade,
            estado: estado ?? this.estado,
            cep: cep ?? this.cep,
            telefone: telefone ?? this.telefone,
            celular: celular ?? this.celular,
        );

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        codigo: json["codigo"],
        cpf: json["cpf"],
        nome: json["nome"],
        endereco: json["endereco"],
        bairro: json["bairro"],
        cidade: json["cidade"],
        estado: json["estado"],
        cep: json["cep"],
        telefone: json["telefone"],
        celular: json["celular"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "cpf": cpf,
        "nome": nome,
        "endereco": endereco,
        "bairro": bairro,
        "cidade": cidade,
        "estado": estado,
        "cep": cep,
        "telefone": telefone,
        "celular": celular,
    };
}
