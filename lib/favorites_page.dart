import 'package:flutter/material.dart';
import 'comic.dart';

class FavoritePage extends StatelessWidget {
  final List<Comic> favoriteComics;

  FavoritePage({required this.favoriteComics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteComics.length,
        itemBuilder: (BuildContext context, int index) {
          final comic = favoriteComics[index];
          return ListTile(
            leading: Image.network(
              comic.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(comic.title),
            subtitle: Text(comic.description),
          );
        },
      ),
    );
  }
}