import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:cadusuario_frontend/service/cadastro_usuario_service.dart';
import 'package:rxdart/rxdart.dart';

class CadastroUsuarioBloc {
  bool _forceReload = false;
  final BehaviorSubject _controller = BehaviorSubject();

  Sink get dataIn => _controller.sink;

  Stream<List<CadastroUsuarioModel>> get dataOut => _controller.stream.asyncMap(
        (_) {
          Future<List<CadastroUsuarioModel>> data = getCadastroUsuario(forceReload: _forceReload);

          _forceReload = false;

          return data;
        },
      );

  CadastroUsuarioBloc() {
    load();
  }

  Future<Null> load() async {
    dataIn.add(null);
  }

  Future<Null> reLoad() async {
    await getCadastroUsuario(forceReload: true);
    _forceReload = true;

    load();
  }

  Future<Null> save(CadastroUsuarioModel cadastroUsuarioModel) async {
    await postCadastroUsuario(cadastroUsuarioModel);

    reLoad();
  }

  Future<Null> update(CadastroUsuarioModel cadastroUsuarioModel) async {
    await putCadastroUsuario(cadastroUsuarioModel);

    reLoad();
  }

  Future<Null> delete(CadastroUsuarioModel cadastroUsuarioModel) async {
    await deleteCadastroUsuario(cadastroUsuarioModel);

    reLoad();
  }

  void dispose() {
    _controller.close();
  }
}
