import 'package:dio/dio.dart';

class Services {
  String baseUrl = 'https://gateway.marvel.com'; 
  Dio dio = Dio();

   getCharacters() async {
    try {
      String urlCharacters = '/v1/public/characters';
      
      // '${baseUrl}${urlCharacters}?apiKey=${}&hash=${}&ts=${}'
      final String url = '';
      final response = await dio.get(url);

      final characters = response.data;
      
      // List<Badges> badges = List<Badges>.from(achievements.map((achievement) => Badges.fromJson(achievement)));

      return characters;
    } catch (e) {
      print(e);
    }
  }
}