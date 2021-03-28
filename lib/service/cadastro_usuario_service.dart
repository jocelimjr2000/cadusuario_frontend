import 'dart:convert';

import 'package:cadusuario_frontend/app/endpoints.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:http/http.dart' as http;

Future<List<CadastroUsuarioModel>> fetchCadastroUsuario({bool forceReload}) async {
  final response = await http.get(Uri.https(URL_API, ENDPOINT_CADASTRO_USUARIO));

  if (response.statusCode == 200) {
    Iterable list = jsonDecode(response.body);
    print(list);
    return list.map((model) => CadastroUsuarioModel.fromMap(model)).toList();
  } else {
    throw Exception('Falha ao carregar');
  }
}
