import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/bloc/cadastro_usuario_bloc.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioFormWidget extends StatefulWidget {
  final CadastroUsuarioModel cadastroUsuarioModel;

  CadastroUsuarioFormWidget(this.cadastroUsuarioModel);

  @override
  _CadastroUsuarioFormWidgetState createState() => _CadastroUsuarioFormWidgetState();
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

  TextEditingController _cpfController;
  TextEditingController _nomeController;
  TextEditingController _dtNascimentoController;
  TextEditingController _emailController;
  TextEditingController _nivelController;

  bool _novo = false;

  @override
  void initState() {
    super.initState();

    _cpfController = TextEditingController(text: widget.cadastroUsuarioModel.cpf);
    _nomeController = TextEditingController(text: widget.cadastroUsuarioModel.nome);
    _dtNascimentoController = TextEditingController(text: widget.cadastroUsuarioModel.dtNascimento);
    _emailController = TextEditingController(text: widget.cadastroUsuarioModel.email);
    _nivelController = TextEditingController(text: widget.cadastroUsuarioModel.nivel.toString());

    if(widget.cadastroUsuarioModel.cpf == ''){
      _novo = true;
    }
  }

  _salvar() async {
    if (_formKey.currentState.validate()) {
      widget.cadastroUsuarioModel.cpf = _cpfController.text;
      widget.cadastroUsuarioModel.nome = _nomeController.text;
      widget.cadastroUsuarioModel.dtNascimento = _dtNascimentoController.text;
      widget.cadastroUsuarioModel.email = _emailController.text;
      widget.cadastroUsuarioModel.nivel = int.parse(_nivelController.text);

      if (_novo) {
        await _cadastroUsuarioBloc.save(widget.cadastroUsuarioModel);
        Navigator.pop(context);
      } else {
        await _cadastroUsuarioBloc.update(widget.cadastroUsuarioModel);
        Navigator.pop(context);
      }
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
              TextFormField(controller: _cpfController, decoration: InputDecoration(hintText: CPF), maxLength: 11, validator: _validar),
              TextFormField(controller: _nomeController, decoration: InputDecoration(hintText: NOME), maxLength: 200, validator: _validar),
              TextFormField(controller: _dtNascimentoController, decoration: InputDecoration(hintText: DATA_NASCIMENTO), maxLength: 40, validator: _validar),
              TextFormField(controller: _emailController, decoration: InputDecoration(hintText: EMAIL), keyboardType: TextInputType.emailAddress, maxLength: 40, validator: _validar),
              TextFormField(controller: _nivelController, decoration: InputDecoration(hintText: NIVEL), keyboardType: TextInputType.phone, maxLength: 1, validator: _validar),
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
      body: _body(),
    );
  }

  @override
  void dispose() {
    _cadastroUsuarioBloc.dispose();

    _cpfController.dispose();
    _nomeController.dispose();
    _dtNascimentoController.dispose();
    _emailController.dispose();
    _nivelController.dispose();

    super.dispose();
  }
}
