import 'package:dart/favorites_page.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final dynamic favoriteComics;
  final int _currentPage = 0;
  const MyBottomNavBar({super.key, required this.favoriteComics});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/search');
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FavoritePage(favoriteComics: favoriteComics),
              ),
            );
          } else if (index == 3){
            Navigator.pushNamed(context, '/comic');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.black),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tablet_android, color: Colors.black),
            label: 'List',
          ),
        ],
        selectedItemColor: Colors.black,
        currentIndex: _currentPage,
      );
  }
}