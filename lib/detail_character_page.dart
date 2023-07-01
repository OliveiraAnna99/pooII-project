import 'package:flutter/material.dart';
import 'comic.dart';
class DetailPersonagemPage extends StatelessWidget {


  DetailPersonagemPage({super.key, required this.personagem});

  final dynamic personagem;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Personagem'),
      ),
        body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    personagem.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Flexible(child:
                Image.network(
                  personagem.image,
                  width: 200,
                  fit: BoxFit.contain,
                )),),
                if (personagem.description == "") 
                const Text("Não possui descrição", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),)
                else
                Text(
                  'Descrição:\n ${personagem.description}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
 
}

