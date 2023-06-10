import 'package:flutter/material.dart';

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
              child: Text(
                'Página 1',
                style: TextStyle(fontSize: 24, color: Colors.white),
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
            icon: Icon(Icons.looks_one),
            label: 'Página 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: 'Página 2',
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.settings),
            label: 'Cin',
          ),
        ],
      ),
    );
  }
}