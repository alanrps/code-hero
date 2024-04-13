import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Services {
  String baseUrl = 'https://gateway.marvel.com';
  Dio dio = Dio();
  getCharacters() async {
    try {
      String urlCharacters = '/v1/public/characters';
      String parameters =
          '?ts=${dotenv.env['TS']}&apikey=${dotenv.env['PUBLIC_KEY']}&hash=${dotenv.env['HASH']}';
      print('PARAMETERS $parameters');
      
      // {String name = ''}
      // if (name != '') {
      //   String nameParameter = '&name=$name';
      //   parameters = '$parameters$nameParameter';
      // }

      print('URL $baseUrl$urlCharacters$parameters');
      final response = await dio.get('$baseUrl$urlCharacters$parameters');
      print('API RESPONSE: $response');

      // final response = await http.get(Uri.parse('$baseUrl$urlCharacters$parameters'));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get characters');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to get characters');
    }
  }
}
