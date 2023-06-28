import 'package:flutter/material.dart';
import 'comic.dart';
class DetailPersonagemPage extends StatelessWidget {
  final int personagemId;
  final String personagemNome;

  DetailPersonagemPage({required this.personagemId, required this.personagemNome});

  @override
  Widget build(BuildContext context) {
    final comicDetails = getComicDetailsById(personagemId, personagemNome);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Personagem'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comicDetails.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Image.network(
              comicDetails.image,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Descrição:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              comicDetails.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  
  Comic getComicDetailsById(int id, String nome) {
   
    return Comic(
      id: id,
      title: nome,
      image: 'Imagem do Personagem',
      description: 'Descrição do Personagem',
    );
  }
}

