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

class Comic {
  final int id;
  final String title;
  final String description;
  final String image;

  Comic({required this.id, required this.title, required this.description, required this.image});
}

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Comic> comics = [];

  @override
  void initState() {
    super.initState();
    fetchComics();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchComics() async {
    final ts = '1';
    final publicKey = '72332a467099deb37887145eca3d01a2';
    final privateKey = 'YOUR_PRIVATE_KEY';
    final hash = '79bb9c041d3a9fb28617b827b80ec5a5';

    final url =
        'http://gateway.marvel.com/v1/public/comics?ts=1&apikey=72332a467099deb37887145eca3d01a2&hash=79bb9c041d3a9fb28617b827b80ec5a5';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> comicList = data['data']['results'];

        setState(() {
          comics = comicList.map((item) {
            return Comic(
              id: item['id'],
              title: item['title'],
              description: item['description'] ?? 'No description available',
              image: item['thumbnail']['path'] +
                  '.' +
                  item['thumbnail']['extension'],
            );
          }).toList();
        });
      } else {
        print('Error making request: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
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
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: ListView.builder(
                itemCount: comics.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= comics.length - 1) {
                    // Reached the end of the list, fetch more data
                    fetchComics();
                    return CircularProgressIndicator(); // Show a loading indicator
                  }
                  final comic = comics[index];
                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return DataTable(
                        columnSpacing: constraints.maxWidth * 0.02,
                        dataRowHeight: 220,
                        columns: [
                          DataColumn(
                            label: Container(
                              width: constraints.maxWidth * 0.3,
                              child: Text(
                                '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: constraints.maxWidth * 0.7,
                              child: Text(
                                '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: constraints.maxWidth * 0.3,
                                  height: 100,
                                  child: Image.network(comic.image),
                                ),
                              ),
                              DataCell(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Titulo: ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(comic.title),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "Descrição: ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Container(
                                            constraints: BoxConstraints(maxWidth: 100), // Defina a largura máxima desejada
                                            child: Text(
                                              comic.description,
                                              overflow: TextOverflow.ellipsis, // Define o comportamento de overflow
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
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
            backgroundColor: Colors.white, // Define a cor de fundo do botão selecionado
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