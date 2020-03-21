// To parse this JSON data, do
//
//     final municipio = municipioFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Municipio municipioFromJson(String str) => Municipio.fromJson(json.decode(str));

String municipioToJson(Municipio data) => json.encode(data.toJson());

class Municipio {
  final int idPessoa;
  final int idMunicipio;
  final String municipioNome;
  final String municipioEstado;
  final String paisNome;

  Municipio({
    @required this.idPessoa,
    @required this.idMunicipio,
    @required this.municipioNome,
    @required this.municipioEstado,
    @required this.paisNome,
  });

  Municipio copyWith({
    int idPessoa,
    int idMunicipio,
    String municipioNome,
    String municipioEstado,
    String paisNome,
  }) =>
      Municipio(
        idPessoa: idPessoa ?? this.idPessoa,
        idMunicipio: idMunicipio ?? this.idMunicipio,
        municipioNome: municipioNome ?? this.municipioNome,
        municipioEstado: municipioEstado ?? this.municipioEstado,
        paisNome: paisNome ?? this.paisNome,
      );

  factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
    idPessoa: json["id_pessoa"],
    idMunicipio: json["id_municipio"],
    municipioNome: json["municipio_nome"],
    municipioEstado: json["municipio_estado"],
    paisNome: json["pais_nome"],
  );

  Map<String, dynamic> toJson() => {
    "id_pessoa": idPessoa,
    "id_municipio": idMunicipio,
    "municipio_nome": municipioNome,
    "municipio_estado": municipioEstado,
    "pais_nome": paisNome,
  };

  factory Municipio.fromMap(Map<String, dynamic> json) => Municipio(
    idPessoa: json["id_pessoa"],
    idMunicipio: json["id_municipio"],
    municipioNome: json["municipio_nome"],
    municipioEstado: json["municipio_estado"],
    paisNome: json["pais_nome"],
  );

  Map<String, dynamic> toMap() => {
    "id_pessoa": idPessoa,
    "id_municipio": idMunicipio,
    "municipio_nome": municipioNome,
    "municipio_estado": municipioEstado,
    "pais_nome": paisNome,
  };
}
