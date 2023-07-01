import 'dart:convert';

import 'package:binder/binder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComicService{
  final ValueNotifier<List<dynamic>> comicStateNotifier = ValueNotifier([]);
  final comicRef = StateRef(const <List<dynamic>>[]);

  ComicService(){
    fetchComics();
  }

    Future<void> fetchComics() async {
    const ts = '1';
    const publicKey = '72332a467099deb37887145eca3d01a2';
    const hash = '79bb9c041d3a9fb28617b827b80ec5a5';

    const url =
        'http://gateway.marvel.com/v1/public/comics?ts=$ts&apikey=$publicKey&hash=$hash';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> comicList = data['data']['results'];
      

      } else {
        print('Error making request: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}

final comicService = ComicService();

class ComicPage extends StatelessWidget {
  const ComicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: comicService.comicStateNotifier,
        builder: (context, value, child) {
          if (comicService.comicStateNotifier.value.isEmpty){
            return Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
            itemCount: comicService.comicStateNotifier.value.length,
            itemBuilder: (context, index) {
              var comic = comicService.comicStateNotifier.value[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Text(comic['title'], )
                    ],
                  )
                ],
              );
            },
          );
        }
      ),
    );
  }
}