import 'package:http/http.dart'as http;
import 'dart:convert';
import 'model/Video.dart';

const CHAVE_YOUTUBE_API= "AIzaSyAOTBqaFp21gFTEauNhQ2nUUPNGWw4FLf0";
const ID_CANAL= "UCo1NFvGMQlclcg9RN4x2npw";
const URL_BASE="https://www.googleapis.com/youtube/v3/search";

class Api {
  Future<void> pesquisar(String query) async {

    final response = await http.get(
      Uri.parse(
        "$URL_BASE"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL" // Se tirar ("&channelId=$ID_CANAL") faz a pesquisa em todos os canais
            "&q=$query",
      ),
    );

    if (response.statusCode == 200) {

      Map<String , dynamic> dadosJason = json.decode(response.body);
      List<Video> videos = dadosJason["items"].map<Video>(
          (map){
            return Video.fromJson(map);
           // return Video.converterJson(map);
          }
      ).toList();
      for(var video in videos){
       print ("resultados: "+ video.titulo);

      }


      // for(var video in dadosJason["items"]){
      //   print ("resultado: "+video.toString());
      // }

     // print("resultado " + dadosJason["items"][0]["id"]["videoId"].toString());

    } else {
      print("Erro ao fazer a requisição: ${response.statusCode}");
    }
  }
}

