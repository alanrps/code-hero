import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Services {
  String baseUrl = 'https://gateway.marvel.com';
  Dio dio = Dio();
  getCharacters({String name = '', int offset = 0}) async {
    try {
      String urlCharacters = '/v1/public/characters';
      String parameters =
          '?ts=${dotenv.env['TS']}&apikey=${dotenv.env['PUBLIC_KEY']}&hash=${dotenv.env['HASH']}';
      print('PARAMETERS $parameters');
      
      if (name != '') {
        String nameParameter = '&nameStartsWith=$name';
        parameters = '$parameters$nameParameter';
      }

      String offsetParameter = '&offset=$offset';
      String limitParameter = '&limit=4';
      parameters = '$parameters$offsetParameter$limitParameter';
  
      print('URL $baseUrl$urlCharacters$parameters');
      final response = await dio.get('$baseUrl$urlCharacters$parameters',
      // queryParameters: {
          // 'apikey': publicKey,
          // 'ts': timestamp,
          // 'hash': hash,
        // }
        );
      print(response.data.toString());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get characters');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to get characters');
    }
  }
}
