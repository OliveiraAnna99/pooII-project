import 'package:dart/components/MyBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'comic.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'favorites_page.dart';
import 'detail_character_page.dart';
import 'detail_comic_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _pageController = PageController(initialPage: 0);
  List<Comic> comics = [];
  List<Personagem> personagens = [];
  List<Comic> favoriteComics = [];
  List<Personagem> favoritePersonagens = [];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchComics();
    fetchPersonagens();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
              isFavorite: false,
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

  Future<void> fetchPersonagens() async {
    const  ts = '1';
    const  publicKey = '72332a467099deb37887145eca3d01a2';
    const  hash = '79bb9c041d3a9fb28617b827b80ec5a5';

    const urlPersonagens =
        'http://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash';

    try {
      final responsePersonagens = await http.get(Uri.parse(urlPersonagens));
      if (responsePersonagens.statusCode == 200) {
        final data = json.decode(responsePersonagens.body);
        final List<dynamic> personagemList = data['data']['results'];

        setState(() {
          personagens = personagemList.map((item) {
            return Personagem(
              id: item['id'],
              title: item['name'],
              description: item['description'] ?? 'No description available',
              image: item['thumbnail']['path'] +
                  '.' +
                  item['thumbnail']['extension'],
              isFavorite: false,
            );
          }).toList();
        });
      } else {
        print('Error making request: ${responsePersonagens.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void toggleFavorite(Comic comic) {
    setState(() {
      if (favoriteComics.contains(comic)) {
        favoriteComics.remove(comic);
        comic.isFavorite = false;
      } else {
        favoriteComics.add(comic);
        comic.isFavorite = true;
      }
    });
  }

  void toggleFavoritePersonagem(Personagem personagem) {
    setState(() {
      if (favoritePersonagens.contains(personagem)) {
        favoritePersonagens.remove(personagem);
        personagem.isFavorite = false;
      } else {
        favoritePersonagens.add(personagem);
        personagem.isFavorite = true;
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
          .where((comic) =>
              comic.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  List<Personagem> getFilteredPersonagens() {
    if (searchQuery.isEmpty) {
      return personagens;
    } else {
      return personagens
          .where((personagem) => personagem.title
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Search for a content")),
      body: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.8,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Comics',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getFilteredComics().length,
                  itemBuilder: (BuildContext context, int index) {
                    final comic = getFilteredComics()[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailComicPage(comic: comic),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Flexible(
                              child: Image.network(
                                comic.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(comic.title, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, )),
                                IconButton(
                                  icon: Icon(
                                    comic.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: comic.isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    toggleFavorite(comic);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personagens',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getFilteredPersonagens().length,
                  itemBuilder: (BuildContext context, int index) {
                    final personagem = getFilteredPersonagens()[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPersonagemPage(personagem: personagem,),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Flexible(
                              child: Image.network(
                                personagem.image,
                                width: 200,
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                              Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(personagem.title, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, )),
                                IconButton(
                                  icon: Icon(
                                    personagem.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: personagem.isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(favoriteComics: favoriteComics)
    );
  }
}
