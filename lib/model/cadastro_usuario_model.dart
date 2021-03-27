import 'dart:convert';

class CadastroUsuarioModel {
  final String cpf;
  final String nome;
  final String email;
  final String celular;

  CadastroUsuarioModel({this.cpf, this.nome, this.email, this.celular,});

  factory CadastroUsuarioModel.fromMap(Map<String, dynamic> map) {
    return CadastroUsuarioModel(
      cpf: map['cpf'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
      celular: map['celular'] as String,
    );
  }

  factory CadastroUsuarioModel.fromJson(String json) {
    return CadastroUsuarioModel.fromMap(jsonDecode(json));
  }
}
