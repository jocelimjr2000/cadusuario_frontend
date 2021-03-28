import 'package:cadusuario_frontend/app/constants.dart';
import 'package:cadusuario_frontend/app/my_homepage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: CADASTRO_USUARIO,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: CADASTRO_USUARIO,)
    );
  }
}
