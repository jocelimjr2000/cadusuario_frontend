import 'dart:convert';

import 'package:cadusuario_frontend/app/endpoints.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:dio/dio.dart';

Future<List<CadastroUsuarioModel>> getCadastroUsuario() async {
  Response response = await Dio().get(ENDPOINT_CADASTRO_USUARIO_PENDENTE);
  if (response.statusCode == 201) {
    return (response.data as List).map((x) => CadastroUsuarioModel.fromMap(x)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}

Future<CadastroUsuarioModel> postCadastroUsuario(CadastroUsuarioModel cadastroUsuarioModel) async {
  Response response = await Dio().post(ENDPOINT_CADASTRO_USUARIO, data: cadastroUsuarioModel.toJson());
  if (response.statusCode == 201) {
    return CadastroUsuarioModel.fromMap(response.data);
  } else {
    throw Exception(response.statusCode);
  }
}

Future<CadastroUsuarioModel> putCadastroUsuario(CadastroUsuarioModel cadastroUsuarioModel) async {
  Response response = await Dio().post(ENDPOINT_CADASTRO_USUARIO, data: cadastroUsuarioModel.toJson());
  if (response.statusCode == 201) {
    return CadastroUsuarioModel.fromMap(response.data);
  } else {
    throw Exception(response.statusCode);
  }
}