import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/functions/open.dart';
import 'package:cadusuario_frontend/model/cadastro_usuario_model.dart';
import 'package:cadusuario_frontend/screens/cadastro_alterar_status_form_widget.dart';
import 'package:cadusuario_frontend/screens/cadastro_alterar_status_reprovado_widget.dart';
import 'package:cadusuario_frontend/screens/cadastro_alterar_status_widget.dart';
import 'package:cadusuario_frontend/screens/cadastro_login_form_widget.dart';
import 'package:cadusuario_frontend/screens/cadastro_usuario_form_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Image.asset(
            "images/btm.jpg",
          ),
          Text('Início'),
        ],
      ), //todo inserir home
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/btm.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(LOGIN),
                onTap: () => {
                  Navigator.pop(context),
                  open(context, CadastroLoginFormWidget()),
                },
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(CADASTRAR_NOVO_USUARIO),
                onTap: () => {
                  Navigator.pop(context),
                open(context, CadastroUsuarioFormWidget(new CadastroUsuarioModel())),
                },
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(USUARIOS_APROVADOS),
                onTap: () => {
                  Navigator.pop(context),
                  open(context, CadastroUsuarioWidget()),
                },
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(ALTERAR_STATUS),
                onTap: () => {
                  Navigator.pop(context),
                  open(context, CadastroAlterarStatusWidget()),
                },
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(PESQUISAR_USUARIO),
                onTap: () => {
                  Navigator.pop(context),
                  //open(context, CadastroPesquisarUsuarioWidget()),
                },
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text(USUARIOS_REPROVADOS),
                onTap: () => {
                  Navigator.pop(context),
                  open(context, CadastroAlterarStatusReprovadoWidget()),
                },
              ),
            ),
            Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text('Movimentação de estoque'),
                onTap: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
