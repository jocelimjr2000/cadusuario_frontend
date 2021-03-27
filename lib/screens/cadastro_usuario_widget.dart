import 'package:cadusuario_frontend/app/constants.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioWidget extends StatefulWidget {
  @override
  CadastroUsuarioWidgetState createState() {
    return CadastroUsuarioWidgetState();
  }
}

class CadastroUsuarioWidgetState extends State<CadastroUsuarioWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextFormField(decoration: InputDecoration(hintText: CPF), maxLength: 11, validator: _validar),
          TextFormField(decoration: InputDecoration(hintText: NOME), maxLength: 200, validator: _validar),
          TextFormField(decoration: InputDecoration(hintText: EMAIL), keyboardType: TextInputType.emailAddress, maxLength: 40, validator: _validar),
          TextFormField(decoration: InputDecoration(hintText: CELULAR), keyboardType: TextInputType.phone, maxLength: 10, validator: _validar),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(PROCESSANDO)));
                }
              },
              child: Text(SALVAR),
            ),
          ),
        ],
      ),
    );
  }
}

String _validar(String value) {
  if (value == null || value.isEmpty) {
    return VALOR_INCORRETO;
  }
}
