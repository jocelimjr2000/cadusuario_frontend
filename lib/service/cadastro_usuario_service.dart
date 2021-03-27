import 'package:cadusuario_frontend/app/endpoints.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:http/http.dart' as http;

Future<List<CadastroUsuarioModel>> fetchCadastroUsuario() async {
  final response = await http.get(Uri.https(ENDPOINT_CADASTRO_USUARIO, ''));

  if (response.statusCode == 200) {
    return _parseCadastroUsuario();
  } else {
    throw Exception('Failed to load album');
  }
}

List<CadastroUsuarioModel> _parseCadastroUsuario({Map<String, dynamic> map}) {
  return (map["data"]).map<CadastroUsuarioModel>((value) => new CadastroUsuarioModel.fromMap(value)).toList();
}
