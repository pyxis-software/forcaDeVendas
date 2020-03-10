// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

class Usuario {
    int usuarioId;
    String usuarioNome;
    int colaboradorId;
    String colaboradorNome;
    int empresaId;
    String empresaFantasia;
    String usuarioSenha;

    Usuario({
        this.usuarioId,
        this.usuarioNome,
        this.colaboradorId,
        this.colaboradorNome,
        this.empresaId,
        this.empresaFantasia,
        this.usuarioSenha,
    });

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        usuarioId: json["usuario_id"],
        usuarioNome: json["usuario_nome"],
        colaboradorId: json["colaborador_id"],
        colaboradorNome: json["colaborador_nome"],
        empresaId: json["empresa_id"],
        empresaFantasia: json["empresa_fantasia"],
        usuarioSenha: json["usuario_senha"],
    );

    Map<String, dynamic> toMap() => {
        "usuario_id": usuarioId,
        "usuario_nome": usuarioNome,
        "colaborador_id": colaboradorId,
        "colaborador_nome": colaboradorNome,
        "empresa_id": empresaId,
        "empresa_fantasia": empresaFantasia,
        "usuario_senha": usuarioSenha,
    };
}