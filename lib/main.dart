import 'package:flutter/material.dart';
import 'initial_page.dart';
import 'search_page.dart';
import 'home_page.dart';
import 'favorites_page.dart';
import 'comic.dart'; // Importe a classe Comic

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Comic> favoriteComics = []; // Declare e inicialize a lista de quadrinhos favoritos

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/search': (context) => SearchPage(),
        '/favorites': (context) => FavoritePage(favoriteComics: favoriteComics),
      },
    );
  }
}
