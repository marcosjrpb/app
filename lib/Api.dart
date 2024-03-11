import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/Video.dart';

const CHAVE_YOUTUBE_API="AIzaSyAOTBqaFp21gFTEauNhQ2nUUPNGWw4FLf0";
const ID_CANAL="UCo1NFvGMQlclcg9RN4x2npw";
const URL_BASE="https://www.googleapis.com/youtube/v3/search";
class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(
      Uri.parse(
        "$URL_BASE/"
            "?part=snippet"
            "&type=video"
            "&maxResults=10"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa",
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<Video> videos = dadosJson["items"].map<Video>(
            (map) {
          return Video.fromJson(map);
        },
      ).toList();
      return videos;
    } else {
      print("Erro ao fazer a requisição: ${response.statusCode}");
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

}
