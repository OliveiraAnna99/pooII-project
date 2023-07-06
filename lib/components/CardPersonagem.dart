import 'package:flutter/material.dart';

class PersonagemCard extends StatelessWidget {
  final dynamic personagem;
  const PersonagemCard({super.key, required this.personagem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.redAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                  children: [
                    Image(
                      image: NetworkImage(
                        personagem['thumbnail']['path'] +
                            '.' +
                            personagem['thumbnail']['extension'],
                      ),
                      height: 200,
                      width: 230,
                    ),
                    SizedBox(
                      width: 170,
                      child: Center(
                       child: Text(
                          (personagem['description'] == null || personagem['description'] == "")
                              ? ((personagem['name'] == null || personagem['name'] == '')
                                  ? "Não possui"
                                  : personagem['name'])
                              : personagem['description'],
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),

                      ),
                    ),
                  ]),
            )));
  }
}
