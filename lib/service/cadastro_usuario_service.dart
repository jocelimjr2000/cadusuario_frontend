import 'dart:convert';

import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/app/endpoints.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:http/http.dart' as http;

Future<List<CadastroUsuarioModel>> getCadastroUsuario({bool forceReload}) async {
  final response = await http.get(Uri.https(URL_API, ENDPOINT_CADASTRO_USUARIO));

  if (response.statusCode == 200) {
    Iterable list = jsonDecode(response.body);
    return list.map((model) => CadastroUsuarioModel.fromMap(model)).toList();
  } else {
    throw Exception(response.statusCode);
  }
}

Future<CadastroUsuarioModel> postCadastroUsuario(CadastroUsuarioModel cadastroUsuarioModel) async {
  final response = await http.post(
    Uri.https(URL_API, ENDPOINT_CADASTRO_USUARIO),
    headers: <String, String>{
      CONTEUDO: APLICACAO,
    },
    body: jsonEncode(cadastroUsuarioModel.toMap()),
  );

  if (response.statusCode == 201) {
    return CadastroUsuarioModel.fromMap(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

Future<CadastroUsuarioModel> putCadastroUsuario(CadastroUsuarioModel cadastroUsuarioModel) async {
  final http.Response response = await http.put(
    Uri.https(URL_API, '$ENDPOINT_CADASTRO_USUARIO/${cadastroUsuarioModel.id.toString()}'),
    headers: <String, String>{
      CONTEUDO: APLICACAO,
    },
    body: jsonEncode(cadastroUsuarioModel.toMap()),
  );

  if (response.statusCode == 200) {
    return CadastroUsuarioModel.fromMap(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}

Future<CadastroUsuarioModel> deleteCadastroUsuario(CadastroUsuarioModel cadastroUsuarioModel) async {
  final http.Response response = await http.delete(
    Uri.https(URL_API, '$ENDPOINT_CADASTRO_USUARIO/${cadastroUsuarioModel.id.toString()}'),
    headers: <String, String>{
      CONTEUDO: APLICACAO,
    },
  );

  if (response.statusCode == 200) {
    return CadastroUsuarioModel.fromMap(jsonDecode(response.body));
  } else {
    throw Exception(response.statusCode);
  }
}
