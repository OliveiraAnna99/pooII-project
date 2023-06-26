import 'package:flutter/material.dart';
import 'comic.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'favorites_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Comic> comics = [];
  List<Personagem> personagens = [];
  List<Comic> favoriteComics = [];
  List<Personagem> favoritePersonagens = [];

  String searchQuery = '';

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

    final urlPersonagens =
        'http://gateway.marvel.com/v1/public/characters?ts=1&apikey=72332a467099deb37887145eca3d01a2&hash=79bb9c041d3a9fb28617b827b80ec5a5';

    try {
      final response = await http.get(Uri.parse(url));
      final responsePersonagens = await http.get(Uri.parse(urlPersonagens));
      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        final List<dynamic> comicList = data['data']['results'];

        setState(() {
          comics = comicList.map((item) {
            return Comic(
              id: item['id'],
              title: item['title'],
              description: item['description'] ?? 'No description available',
              image: item['thumbnail']['path'] + '.' + item['thumbnail']['extension'],
              isFavorite: false, // Adicionei o valor inicial de isFavorite como false
            );
          }).toList();
        });
      } else if (responsePersonagens.statusCode == 200) {
        final data = json.decode(responsePersonagens.body);
        final List<dynamic> personagemList = data['data']['results'];

        setState(() {
          personagens = personagemList.map((item) {
            return Personagem(
              id: item['id'],
              title: item['name'],
              description: item['description'] ?? 'No description available',
              image: item['thumbnail']['path'] + '.' + item['thumbnail']['extension'],
              isFavorite: false, // Adicionei o valor inicial de isFavorite como false
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

  void toggleFavorite(Comic comic) {
    setState(() {
      if (favoriteComics.contains(comic)) {
        favoriteComics.remove(comic);
        comic.isFavorite = false; // Atualizei o valor de isFavorite
      } else {
        favoriteComics.add(comic);
        comic.isFavorite = true; // Atualizei o valor de isFavorite
      }
    });
  }
 
  void toggleFavoritePersonagem(Personagem personagem) {
    setState(() {
      if (favoritePersonagens.contains(personagem)) {
        favoritePersonagens.remove(personagem);
        personagem.isFavorite = false; // Atualizei o valor de isFavorite
      } else {
        favoritePersonagens.add(personagem);
        personagem.isFavorite = true; // Atualizei o valor de isFavorite
      }
    });
  }

  void searchComics(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Comic> getFilteredComics() {
    if (searchQuery.isEmpty) {
      return comics;
    } else {
      return comics
          .where((comic) => comic.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  List<Personagem> getFilteredPersonagens() {
    if (searchQuery.isEmpty) {
      return personagens;
    } else {
      return personagens
          .where((personagem) => personagem.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Search for a content',
                        style: TextStyle(fontSize: 18.0, color: Color.fromARGB(197, 0, 0, 0)),
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          onChanged: (value) {
                            searchComics(value);
                          },
                          decoration: InputDecoration(
                            labelText: 'Search for a content',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getFilteredComics().length,
                    itemBuilder: (BuildContext context, int index) {
                      final comic = getFilteredComics()[index];
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    comic.image,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    comic.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: comic.isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    toggleFavorite(comic);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(comic.title),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getFilteredPersonagens().length,
                    itemBuilder: (BuildContext context, int index) {
                      final personagem = getFilteredPersonagens()[index];
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    personagem.image,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    personagem.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: personagem.isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    toggleFavoritePersonagem(personagem);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(personagem.title),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/search');
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(favoriteComics: favoriteComics),
              ),
            );
          }
        },
        items: [
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
        ],
        selectedItemColor: Colors.black,
        currentIndex: _currentPage, // Definir o índice atual do BottomNavigationBar
      ),
    );
  }
}
