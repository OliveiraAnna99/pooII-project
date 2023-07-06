import 'package:flutter/material.dart';
import 'comic.dart';

class FavoritePage extends StatefulWidget {
  final List<Comic> favoriteComics;

  FavoritePage({required this.favoriteComics});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  ScrollController _scrollController = ScrollController();
  List<Comic> _visibleComics = [];
  int _visibleComicsCount = 10;

  @override
  void initState() {
    super.initState();
    _loadComics();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadComics() {
    setState(() {
      if (_visibleComicsCount < widget.favoriteComics.length) {
        _visibleComics = widget.favoriteComics.sublist(0, _visibleComicsCount);
        _visibleComicsCount += 4;
      } else {
        _visibleComics = widget.favoriteComics;
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadComics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _visibleComics.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == _visibleComics.length) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final comic = _visibleComics[index];
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
