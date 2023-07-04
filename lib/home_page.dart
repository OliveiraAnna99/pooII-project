import 'dart:convert';

import 'package:binder/binder.dart';
import 'package:dart/components/CardComic.dart';
import 'package:dart/components/MyBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


final comicLogicRef = LogicRef((scope) => ComicLogic(scope));

class ComicService{
    var comicRef = StateRef<List<dynamic>>(const []);
}

class ComicLogic with Logic{

  ComicLogic(this.scope);

  @override
  final Scope scope;

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
        update(comicService.comicRef, (dynamic list) => list=[...data['data']['results']]);
      } 
    } catch (error) {
      print('Error: $error');
    }

  }
}

ComicService comicService = ComicService();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch(comicService.comicRef);
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: counter.length,
        itemBuilder: (context, index) {
          if(counter.isEmpty) {
            return Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.7,
              width: 200,
              child: Center(
                child: IconButton(onPressed: ()=> context.use(comicLogicRef).fetchComics(), icon: const Icon(Icons.abc)),
              ),
            );
          }

          var comic = counter[index];
          print(comic['title']);

          return Column(
            children: [ComicCard(comic: comic)],
          );

      },),
      bottomNavigationBar:const MyBottomNavBar(favoriteComics: null),
      );
  }
}
