import 'package:meta/meta.dart';
class Auth {
    final int usuarioId;
    final String usuarioNome;
    final int colaboradorId;
    final String colaboradorNome;
    final int empresaId;
    final String empresaFantasia;
    final String usuarioSenha;

    Auth({
        @required this.usuarioId,
        @required this.usuarioNome,
        @required this.colaboradorId,
        @required this.colaboradorNome,
        @required this.empresaId,
        @required this.empresaFantasia,
        @required this.usuarioSenha,
    });

    Auth copyWith({
        int usuarioId,
        String usuarioNome,
        int colaboradorId,
        String colaboradorNome,
        int empresaId,
        String empresaFantasia,
        String usuarioSenha,
    }) => 
        Auth(
            usuarioId: usuarioId ?? this.usuarioId,
            usuarioNome: usuarioNome ?? this.usuarioNome,
            colaboradorId: colaboradorId ?? this.colaboradorId,
            colaboradorNome: colaboradorNome ?? this.colaboradorNome,
            empresaId: empresaId ?? this.empresaId,
            empresaFantasia: empresaFantasia ?? this.empresaFantasia,
            usuarioSenha: usuarioSenha ?? this.usuarioSenha,
        );

    factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        usuarioId: json["usuario_id"],
        usuarioNome: json["usuario_nome"],
        colaboradorId: json["colaborador_id"],
        colaboradorNome: json["colaborador_nome"],
        empresaId: json["empresa_id"],
        empresaFantasia: json["empresa_fantasia"],
        usuarioSenha: json["usuario_senha"],
    );

    Map<String, dynamic> toJson() => {
        "usuario_id": usuarioId,
        "usuario_nome": usuarioNome,
        "colaborador_id": colaboradorId,
        "colaborador_nome": colaboradorNome,
        "empresa_id": empresaId,
        "empresa_fantasia": empresaFantasia,
        "usuario_senha": usuarioSenha,
    };
}