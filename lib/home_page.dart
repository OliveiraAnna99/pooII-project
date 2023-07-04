import 'dart:convert';

import 'package:binder/binder.dart';
import 'package:dart/components/CardComic.dart';
import 'package:dart/components/MyBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComicService{
    var comicRef = StateRef<List<dynamic>>(const []);
}

class ComicLogic with Logic{

  ComicLogic(this.scope){
    fetchComics();
  }
  
  @override
  final Scope scope;

Future<void> fetchComics() async {
    const ts = '1';
    const publicKey = 'c326f480cc0138bf01c7c01dc9a5966b';
    const hash = 'b301d583a60a6be3769ddb1bf9542ead';

    const url =
        'http://gateway.marvel.com/v1/public/comics?ts=$ts&apikey=$publicKey&hash=$hash';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        update(comicService.comicRef, (dynamic list) => list=[...data['data']['results']]);
      } 
    } catch (error) {
        update(comicService.comicRef, (dynamic list) => list=[null]);
    }

  }
}

ComicService comicService = ComicService();
final comicLogicRef = LogicRef((scope) => ComicLogic(scope));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch(comicService.comicRef);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: const Text("Comics"),),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: counter.length + 1,
        itemBuilder: (context, index) {
          context.use(comicLogicRef).fetchComics();

          if(counter.isEmpty){
            return Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.9,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(color: Colors.red, backgroundColor: Colors.redAccent.withOpacity(0.5),)
              ),
            );
          }

          if(index == counter.length){
             return Container(
              width: 50,
              margin: const EdgeInsets.all(10),
              child: Center(
                child: LinearProgressIndicator(color: Colors.red, backgroundColor: Colors.redAccent.withOpacity(0.5),)
              ),
            );
          }

          var comic = counter[index];

          return Column(
            children: [Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: ComicCard(comic: comic))],
          );

      },),
      bottomNavigationBar:const MyBottomNavBar(favoriteComics: null),
      );
  }
}
