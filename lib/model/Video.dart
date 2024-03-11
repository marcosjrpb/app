import 'package:http/http.dart' as http;
import 'dart:convert';

class Video {
  String id;
  String titulo;
  String imagem;
  String canal;

  Video({
    required this.id,
    required this.titulo,
    required this.imagem,
    required this.canal,
  });
/*
  static converterJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']["videoId"] ?? '',
      titulo: json['snippet']['title'] ?? '',
      imagem: json['snippet']['thumbnails']['high']['url'] ?? '',
      canal: json['snippet']['channelId'] ?? '',
    );
  }
*/
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']["videoId"],
      titulo: json['snippet']['title'],
      imagem: json['snippet']['thumbnails']['high']['url'],
      canal: json['snippet']['channelId'],
    );
  }
}

class Api {
  Future<List<Video>> pesquisar(String query) async {
    final response = await http.get(
      Uri.parse(
        "https://www.googleapis.com/youtube/v3/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&key=YOUR_API_KEY"
        "&channelId=YOUR_CHANNEL_ID"
        "&q=$query",
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<dynamic> items = dadosJson["items"];
      List<Video> videos = items.map((item) => Video.fromJson(item)).toList();
      return videos;
    } else {
      print("Erro ao fazer a requisição: ${response.statusCode}");
      return [];
    }
  }
}
