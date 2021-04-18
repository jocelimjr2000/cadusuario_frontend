import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/bloc/cadastro_alterar_status_bloc.dart';
import 'package:cadusuario_frontend/model/cadastro_alterar_status_model.dart';
import 'package:flutter/material.dart';

class CadastroAlterarStatusFormWidget extends StatefulWidget {

  final CadastroAlterarStatusModel cadastroAlterarStatusModel;

  CadastroAlterarStatusFormWidget(this.cadastroAlterarStatusModel);

  @override
  _CadastroAlterarStatusFormWidgetState createState() => _CadastroAlterarStatusFormWidgetState();
}

//Validação
String _validar(String value) {
  if (value == null || value.isEmpty) {
    return VALOR_INCORRETO;
  }
}

class _CadastroAlterarStatusFormWidgetState extends State<CadastroAlterarStatusFormWidget> {
  final _formKey = GlobalKey<FormState>();

  CadastroAlterarStatusBloc _cadastroAlterarStatusBloc = CadastroAlterarStatusBloc();

  bool _aprovarController;
  TextEditingController _cpfController;

  @override
  void initState() {
    super.initState();

    _aprovarController = false;
    _cpfController = TextEditingController(text: widget.cadastroAlterarStatusModel.cpf);
  }

  _salvar() async {
    if (_formKey.currentState.validate()) {
      widget.cadastroAlterarStatusModel.aprovar = _aprovarController;
      widget.cadastroAlterarStatusModel.cpf = _cpfController.text;

      await _cadastroAlterarStatusBloc.save(widget.cadastroAlterarStatusModel);
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
              TextFormField(controller: _cpfController, decoration: InputDecoration(hintText: CPF), maxLength: 200, validator: _validar),
              Text('Aprovar?'),
              Checkbox(
                value: _aprovarController,
                onChanged: (value) {
                  setState(
                    () {
                      _aprovarController = !_aprovarController;
                    },
                  );
                },
              ),
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
        title: Text(ALTERAR_STATUS),
        backgroundColor: Colors.redAccent,
      ),
      body: _body(),
    );
  }

  @override
  void dispose() {
    _cpfController.dispose();

    super.dispose();
  }
}
