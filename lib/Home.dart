import 'package:appyoutube2/telas/Biblioteca.dart';
import 'package:appyoutube2/telas/EmAlta.dart';
import 'package:appyoutube2/telas/Inicio.dart';
import 'package:appyoutube2/telas/Inscricao.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;
  @override
  Widget build(BuildContext context) {
    List telas =[
      Inicio(),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/youtube.png",
          width: 98,
          height: 22,
        ),
        backgroundColor: Color(0xFFBBBBBB),
        actions: [
          IconButton(
            onPressed: () {
              print("Ação VidoCam");
            },
            icon: Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {
                print("Ação Seach");
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                print("Ação User");
              },
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              )),
        ],
      ),
      body: telas[_indiceAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        //os backgroundColor estão comentados para caso deseje acionar
        //o shifting funcionar.
        fixedColor: Colors.redAccent,
        items: [
          BottomNavigationBarItem(
            label: 'Início',
            icon: Icon(Icons.home),
           // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            label: 'Em Alta',
            icon: Icon(Icons.whatshot),
           // backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            label: '\Inscrição',
            icon: Icon(Icons.subscriptions),
          //  backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            label: '\Biblioteca',
            icon: Icon(Icons.folder_copy),
         //   backgroundColor: Colors.indigo,
          )
        ],
      ),
    );
  }
}
