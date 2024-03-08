import 'package:flutter/material.dart';
import 'package:appyoutube2/Api.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    Api api = Api();

    String pesquisa = "honda"; // Defina o termo de pesquisa aqui

    api.pesquisar(pesquisa); // Passe o termo de pesquisa para o método pesquisar

    return Container(
      child: Center(
        child: Text(
          "Início",
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
