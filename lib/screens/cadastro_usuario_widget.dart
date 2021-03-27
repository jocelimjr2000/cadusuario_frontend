import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/bloc/cadastro_usuario_bloc.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioWidget extends StatefulWidget {
  CadastroUsuarioWidget({Key key, this.idUsuario}) : super(key: key);

  final int idUsuario;

  @override
  CadastroUsuarioWidgetState createState() {
    return CadastroUsuarioWidgetState();
  }
}

//Validação
String _validar(String value) {
  if (value == null || value.isEmpty) {
    return VALOR_INCORRETO;
  }
}

class CadastroUsuarioWidgetState extends State<CadastroUsuarioWidget> {
  final _formKey = GlobalKey<FormState>();

  final CadastroUsuarioBloc _cadastroUsuarioBloc = CadastroUsuarioBloc();

  _body(List<CadastroUsuarioModel> usuarios) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(initialValue: usuarios[widget.idUsuario].id.toString(), decoration: InputDecoration(hintText: CPF), maxLength: 11, validator: _validar),
              TextFormField(initialValue: usuarios[widget.idUsuario].name.toString(), decoration: InputDecoration(hintText: NOME), maxLength: 200, validator: _validar),
              TextFormField(initialValue: usuarios[widget.idUsuario].username.toString(), decoration: InputDecoration(hintText: USERNAME), keyboardType: TextInputType.emailAddress, maxLength: 40, validator: _validar),
              TextFormField(initialValue: usuarios[widget.idUsuario].email.toString(), decoration: InputDecoration(hintText: EMAIL), keyboardType: TextInputType.phone, maxLength: 10, validator: _validar),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SALVANDO)));
                    }
                  },
                  child: Text(SALVAR),
                ),
              ),
            ],
          ),
        ),
      ],
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
        stream: _cadastroUsuarioBloc.dataOut,
        builder: (BuildContext context, AsyncSnapshot<List<CadastroUsuarioModel>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              child: _body(snapshot.data),
              onRefresh: _cadastroUsuarioBloc.reLoad,
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
    _cadastroUsuarioBloc.dispose();
    super.dispose();
  }
}
