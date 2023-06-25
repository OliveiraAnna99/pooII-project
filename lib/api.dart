import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future<List<dynamic>> fetchComics() async {
    final ts = '1';
    final publicKey = '72332a467099deb37887145eca3d01a2';
    final privateKey = 'YOUR_PRIVATE_KEY';
    final hash = '79bb9c041d3a9fb28617b827b80ec5a5';

    final url = 'http://gateway.marvel.com/v1/public/comics?ts=1&apikey=72332a467099deb37887145eca3d01a2&hash=79bb9c041d3a9fb28617b827b80ec5a5';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> comicList = data['data']['results'];

        return comicList;
      } else {
        print('Error making request: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }

    return [];
  }
}
