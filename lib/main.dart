import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPageView(),
    );
  }
}

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginação Flutter'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.amber[600],
                    width: 200.0,
                    height: 108.0,
                  ),
                  Text(
                    'Página 1',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text(
                'Página 2',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text(
                'Página 3',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text(
                'Página 4',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text(
                'Página 5',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int page) {
          _pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: _currentPage == 0 ? Color(0xFFDB0000) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home, color: Colors.black),
            ),
            label: 'Início',
            backgroundColor: Colors.white, // Define a cor de fundo do botão selecionado
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: _currentPage == 1 ? Color(0xFFDB0000) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.save, color: Colors.black),
            ),
            label: 'Salvar',
            backgroundColor: Colors.white, // Define a cor de fundo do botão selecionado
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: _currentPage == 2 ? Color(0xFFDB0000) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search, color: Colors.black),
            ),
            label: 'Pesquisar',
            backgroundColor: Colors.white // Define a cor de fundo do botão selecionado
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: _currentPage == 3 ? Color(0xFFDB0000) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications, color: Colors.black),
            ),
            label: 'Notificações',
            backgroundColor: Colors.white, // Define a cor de fundo do botão selecionado
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 68.0,
              height: 68.0,
              decoration: BoxDecoration(
                color: _currentPage == 4 ? Color(0xFFDB0000) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.settings, color: Colors.black),
            ),
            label: 'Configurações',
            backgroundColor: Colors.white, // Define a cor de fundo do botão selecionado
          ),
        ],
      ),
    );
  }
}