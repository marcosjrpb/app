import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Api.dart';
import '../model/Video.dart';

class Inicio extends StatefulWidget {
  final String pesquisaInicio;

  Inicio(this.pesquisaInicio);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  late YoutubePlayerController _controller;

  // Cria a lista de vídeos que será apresentada ao usuário através da classe API.dart
  Future<List<Video>?> _listarVideos(String pesquisaDoUsuario) async {
    Api myApi = Api();
    return myApi.pesquisar(pesquisaDoUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>?>(
      future: _listarVideos(widget.pesquisaInicio),
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
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video>? auxVideoList = snapshot.data;
                  Video auxVideo = auxVideoList![index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: OrientationBuilder(
                              builder: (context, orientation) {
                                return Container(
                                  width: orientation == Orientation.portrait
                                      ? MediaQuery.of(context).size.width * 0.8
                                      : MediaQuery.of(context).size.width,
                                  height: orientation == Orientation.portrait
                                      ? null
                                      : MediaQuery.of(context).size.height,
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: auxVideo.id,
                                      flags: YoutubePlayerFlags(
                                        mute: false,
                                        autoPlay: true,
                                      ),
                                    ),
                                    aspectRatio: 16 / 9,
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor: Colors.blueAccent,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(auxVideo.imagem),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(auxVideo.titulo),
                          subtitle: Text(auxVideo.descricao),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 3,
                  color: Colors.red,
                ),
                itemCount: snapshot.data!.length,
              );
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido"),
              );
            }
        }
      },
    );
  }
}
