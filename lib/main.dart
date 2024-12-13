import 'package:flutter/material.dart';
import 'sintomas.dart';
import 'tela_login.dart';
import 'escolha.dart';
import 'prevencao.dart';

void main() {
  runApp(MaterialApp(
    home: MeuApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MeuApp extends StatefulWidget {
  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  int indiceAtual = 0;

  List telas = [
    TelaLogin(),
    Escolha(),
    Sintomas(),
    Prevencao(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: telas[indiceAtual],

    );
  }

  void quandoClicar(int index) {
    setState(() {
      indiceAtual = index;
    });
  }
}
