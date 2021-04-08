import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/bloc/cadastro_usuario_bloc.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioFormWidget extends StatefulWidget {
  final CadastroUsuarioModel cadastroUsuarioModel;
  
  CadastroUsuarioFormWidget(this.cadastroUsuarioModel);
  

  @override
  _CadastroUsuarioFormWidgetState createState() =>  _CadastroUsuarioFormWidgetState();
  
}

//Validação
String _validar(String value) {
  if (value == null || value.isEmpty) {
    return VALOR_INCORRETO;
  }
}

class _CadastroUsuarioFormWidgetState extends State<CadastroUsuarioFormWidget> {
  final _formKey = GlobalKey<FormState>();

  CadastroUsuarioBloc _cadastroUsuarioBloc = CadastroUsuarioBloc();

  TextEditingController _idController;
  TextEditingController _nameController;
  TextEditingController _usernameController;
  TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _idController = TextEditingController(text: widget.cadastroUsuarioModel.id.toString());
    _nameController = TextEditingController(text: widget.cadastroUsuarioModel.name);
    _usernameController = TextEditingController(text: widget.cadastroUsuarioModel.username);
    _emailController = TextEditingController(text: widget.cadastroUsuarioModel.email);
  }

  _salvar() async {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SALVANDO)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(FALHA)));
    }
  }

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
              TextFormField(controller: _idController, decoration: InputDecoration(hintText: CPF), maxLength: 11, validator: _validar),
              TextFormField(controller: _nameController, decoration: InputDecoration(hintText: NOME), maxLength: 200, validator: _validar),
              TextFormField(controller: _usernameController, decoration: InputDecoration(hintText: USERNAME), keyboardType: TextInputType.emailAddress, maxLength: 40, validator: _validar),
              TextFormField(controller: _emailController, decoration: InputDecoration(hintText: EMAIL), keyboardType: TextInputType.phone, maxLength: 10, validator: _validar),
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

    _idController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();

    super.dispose();
  }
}
