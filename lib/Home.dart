import 'package:flutter/material.dart';

import 'telas/Biblioteca.dart';
import 'telas/EmAlta.dart';
import 'telas/Inicio.dart';
import 'telas/Inscricao.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(),
      EmAlta(),
      Inscricao(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: (){
              print("acao: videocam");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print("acao: pesquisa");
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: (){
              print("acao: conta");
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: (indice){
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
              //backgroundColor: Colors.orange,
                label:"Início",
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.red,
                label: "Em alta",
                icon: Icon(Icons.whatshot)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.blue,
                label:"Inscrições",
                icon: Icon(Icons.subscriptions)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Colors.green,
                label:"Biblioteca",
                icon: Icon(Icons.folder)
            ),
          ]
      ),
    );
  }
}
