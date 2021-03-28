import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/functions/open.dart';
import 'package:cadusuario_frontend/screens/cadastro_usuario_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: new InputDecoration(labelText: DIGITE_O_ID),
            keyboardType: TextInputType.number,
            controller: textController,
          ),
          ElevatedButton(onPressed: () => open(context, CadastroUsuarioWidget(idUsuario: int.parse(textController.text) - 1)), child: Text(CADASTRO_USUARIO)),
        ],
      ),
    );
  }
}
