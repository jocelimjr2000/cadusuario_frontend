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

  CadastroUsuarioBloc cadastroUsuarioBloc = CadastroUsuarioBloc();

  TextEditingController _cpfController;
  TextEditingController _nomeController;
  TextEditingController _dtNascimentoController;
  TextEditingController _emailController;
  TextEditingController _nivelController;
  TextEditingController _nivelLogadoController;

  bool _novo = false;

  @override
  void initState() {
    super.initState();

    _cpfController = TextEditingController(text: widget.cadastroUsuarioModel.cpf);
    _nomeController = TextEditingController(text: widget.cadastroUsuarioModel.nome);
    _dtNascimentoController = TextEditingController(text: widget.cadastroUsuarioModel.dtNascimento);
    _emailController = TextEditingController(text: widget.cadastroUsuarioModel.email);
    _nivelController = TextEditingController(text: widget.cadastroUsuarioModel.nivel.toString());
    _nivelLogadoController = TextEditingController(text: widget.cadastroUsuarioModel.nivelLogado.toString());

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
      widget.cadastroUsuarioModel.nivelLogado = int.parse(_nivelLogadoController.text);

      if (_novo) {
        await cadastroUsuarioBloc.save(widget.cadastroUsuarioModel);
        Navigator.pop(context);
      } else {
        await cadastroUsuarioBloc.update(widget.cadastroUsuarioModel);
        Navigator.pop(context);
      }
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(controller: _cpfController, decoration: InputDecoration(hintText: CPF), maxLength: 11, validator: _validar),
              TextFormField(controller: _nomeController, decoration: InputDecoration(hintText: NOME), maxLength: 200, validator: _validar),
              TextFormField(controller: _dtNascimentoController, decoration: InputDecoration(hintText: DATA_NASCIMENTO), keyboardType: TextInputType.emailAddress, maxLength: 40, validator: _validar),
              TextFormField(controller: _emailController, decoration: InputDecoration(hintText: EMAIL), keyboardType: TextInputType.phone, maxLength: 10, validator: _validar),
              TextFormField(controller: _nivelController, decoration: InputDecoration(hintText: NIVEL), keyboardType: TextInputType.phone, maxLength: 1, validator: _validar),
              TextFormField(controller: _nivelLogadoController, decoration: InputDecoration(hintText: NIVEL_LOGADO), keyboardType: TextInputType.phone, maxLength: 1, validator: _validar),
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
        stream: cadastroUsuarioBloc.dataOut,
        builder: (BuildContext context, AsyncSnapshot<List<CadastroUsuarioModel>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              child: _body(snapshot.data),
              onRefresh: cadastroUsuarioBloc.load,
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

    _cpfController.dispose();
    _nomeController.dispose();
    _dtNascimentoController.dispose();
    _emailController.dispose();
    _nivelController.dispose();
    _nivelLogadoController.dispose();

    super.dispose();
  }
}
