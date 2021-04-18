import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/bloc/cadastro_login_bloc.dart';
import 'package:cadusuario_frontend/model/cadastro_login_model.dart';
import 'package:flutter/material.dart';

class CadastroLoginFormWidget extends StatefulWidget {
  @override
  _CadastroLoginFormWidgetState createState() => _CadastroLoginFormWidgetState();
}

//Validação
String _validar(String value) {
  if (value == null || value.isEmpty) {
    return VALOR_INCORRETO;
  }
}

class _CadastroLoginFormWidgetState extends State<CadastroLoginFormWidget> {
  final _formKey = GlobalKey<FormState>();

  CadastroLoginModel _cadastroLoginModel = CadastroLoginModel();
  CadastroLoginBloc _cadastroLoginBloc = CadastroLoginBloc();

  TextEditingController _emailController;
  TextEditingController _senhaController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: _cadastroLoginModel.email);
    _senhaController = TextEditingController(text: _cadastroLoginModel.senha);
  }

  _salvar() async {
    if (_formKey.currentState.validate()) {
      _cadastroLoginModel.email = _emailController.text;
      _cadastroLoginModel.senha = _senhaController.text;

      await _cadastroLoginBloc.save(_cadastroLoginModel);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SALVANDO)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(FALHA)));
    }
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(controller: _emailController, decoration: InputDecoration(hintText: EMAIL), maxLength: 200, validator: _validar),
              TextFormField(controller: _senhaController, decoration: InputDecoration(hintText: SENHA), maxLength: 200, validator: _validar),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () => _salvar(),
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
        title: Text(LOGIN),
        backgroundColor: Colors.redAccent,
      ),
      body: _body(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();

    super.dispose();
  }
}
