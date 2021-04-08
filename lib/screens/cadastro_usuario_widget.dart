import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/bloc/cadastro_usuario_bloc.dart';
import 'package:cadusuario_frontend/functions/open.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:cadusuario_frontend/screens/cadastro_usuario_form_widget.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioWidget extends StatefulWidget {
  @override
  _CadastroUsuarioWidgetState createState() => _CadastroUsuarioWidgetState();
}

class _CadastroUsuarioWidgetState extends State<CadastroUsuarioWidget> {
  CadastroUsuarioBloc cadastroUsuarioBloc = CadastroUsuarioBloc();

  void _novo() {
    _alterar(new CadastroUsuarioModel());
  }

  void _alterar(CadastroUsuarioModel cadastroUsuarioModel) {
    openAndExecute(context, CadastroUsuarioFormWidget(cadastroUsuarioModel), cadastroUsuarioBloc.reLoad, null);
  }

  void _excluir(CadastroUsuarioModel cadastroUsuarioModel) async {
    cadastroUsuarioBloc.delete(cadastroUsuarioModel);
  }

  _body(List<CadastroUsuarioModel> cadastroUsuarioModel) {
    List<Widget> items = [];

    if (cadastroUsuarioModel != null) {
      for (int x = 0; x < cadastroUsuarioModel.length; x++) {
        items.add(ListTile(
          leading: Text(cadastroUsuarioModel[x].name),
          title: Text(cadastroUsuarioModel[x].username),
          trailing: ElevatedButton(onPressed: () => _alterar(cadastroUsuarioModel[x]), child: Text('Alterar')),
        ));
      }
    }
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CADASTRO_USUARIO),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder(
        stream: cadastroUsuarioBloc.dataOut,
        builder: (BuildContext context, AsyncSnapshot<List<CadastroUsuarioModel>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              child: _body(snapshot.data),
              onRefresh: cadastroUsuarioBloc.reLoad,
            );
          } else if (snapshot.hasError) {
            return snapshot.error;
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    cadastroUsuarioBloc.dispose();
    super.dispose();
  }
}
