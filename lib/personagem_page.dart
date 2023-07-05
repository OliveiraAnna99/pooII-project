import 'dart:convert';

import 'package:binder/binder.dart';
import 'package:dart/components/CardPersonagem.dart';
import 'package:dart/components/MyBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonagemService{
    var personagemRef = StateRef<List<dynamic>>(const []);
}

class PersonagemLogic with Logic{

  PersonagemLogic(this.scope){
    fetchPersonagens();
  }
  
  @override
  final Scope scope;

Future<void> fetchPersonagens() async {
    const ts = '1';
    const publicKey = 'c326f480cc0138bf01c7c01dc9a5966b';
    const hash = 'b301d583a60a6be3769ddb1bf9542ead';

    const url =
        'http://gateway.marvel.com/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        update(personagemService.personagemRef, (dynamic list) => list=[...data['data']['results']]);
      } 
    } catch (error) {
        update(personagemService.personagemRef, (dynamic list) => list=[null]);
    }

  }
}

PersonagemService personagemService = PersonagemService();
final personagemLogicRef = LogicRef((scope) => PersonagemLogic(scope));

class PesonagemPage extends StatelessWidget {
  const PesonagemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch(personagemService.personagemRef);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: const Text("Personagens"),),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: counter.length + 1,
        itemBuilder: (context, index) {
          context.use(personagemLogicRef).fetchPersonagens();

          if(counter.isEmpty){
            return Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.9,
              width: 200,
              child: Center(
                child: CircularProgressIndicator(color: Colors.red, backgroundColor: Colors.redAccent.withOpacity(0.5),)
              ),
            );
          }

          if(index == counter.length){
             return Container(
              width: 50,
              margin: const EdgeInsets.all(10),
              child: Center(
                child: LinearProgressIndicator(color: Colors.red, backgroundColor: Colors.redAccent.withOpacity(0.5),)
              ),
            );
          }

          var personagem = counter[index];

          return Column(
            children: [Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: PersonagemCard(personagem: personagem))],
          );

      },),
      bottomNavigationBar:const MyBottomNavBar(favoriteComics: null),
      );
  }
}
