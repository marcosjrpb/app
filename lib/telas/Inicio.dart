import 'package:flutter/material.dart';
import 'package:appyoutube2/Api.dart';
import 'package:appyoutube2/model/Video.dart';

class Inicio extends StatefulWidget {

  String pesquisa;
  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  Future<List<Video>> _listarVideos( String pesquisa) async {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Video video = snapshot.data![index];

                  return Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(video.imagem),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(video.titulo),
                        subtitle: Text(video.canal),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
          default:
            return Container(); // Tratamento para outros estados, se necessário
        }
      },
    );
  }
}
