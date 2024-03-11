import 'package:flutter/material.dart';
import 'package:appyoutube2/Api.dart';
import 'package:appyoutube2/model/Video.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Video>> _listarVideos() async {
    Api api = Api();
    return api.pesquisar("");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(),
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
                  List<Video>? videos = snapshot.data;
                  Video video = videos![index];

                  return Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(video.imagem ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(video.titulo!),
                        subtitle: Text(video.canal!),

                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2,
                  color: Colors.blueGrey,
                ),
                itemCount: snapshot.data?.length ?? 0,
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
