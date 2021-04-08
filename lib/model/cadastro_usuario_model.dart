import 'dart:convert';

class CadastroUsuarioModel {
  int id;
  String name;
  String username;
  String email;

  CadastroUsuarioModel({
    this.id = 0,
    this.name = '',
    this.username = '',
    this.email = '',
  });

  factory CadastroUsuarioModel.fromMap(Map<String, dynamic> map) {
    return CadastroUsuarioModel(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  factory CadastroUsuarioModel.fromJson(String json) {
    return CadastroUsuarioModel.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'username': username,
        'email': email,
      };

  String toJson() => jsonEncode(toMap());
}
