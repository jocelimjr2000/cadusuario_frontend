import 'dart:convert';

import 'package:flutter/material.dart';

class CadastroUsuarioModel {
  final int id;
  final String name;
  final String username;
  final String email;

  CadastroUsuarioModel({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.email,
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
