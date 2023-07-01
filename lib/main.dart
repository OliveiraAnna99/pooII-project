import 'package:dart/comic_page.dart';
import 'package:flutter/material.dart';
import 'initial_page.dart';
import 'search_page.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'comic.dart'; // Importe a classe Comic
import 'package:binder/binder.dart';

void main() {
  runApp(BinderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final List<Comic> favoriteComics = []; // Declare e inicialize a lista de quadrinhos favoritos

  @override
  Widget build(BuildContext context) {
    return BinderScope(
      child: MaterialApp(
        home: InitialPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => HomePage(),
          '/search': (context) => SearchPage(),
          '/favorites': (context) => FavoritePage(favoriteComics: favoriteComics),
          '/comic' :(context) => const ComicPage(),
        },
      ),
    );
  }
}
