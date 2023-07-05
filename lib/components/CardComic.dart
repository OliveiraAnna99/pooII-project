import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final dynamic comic;
  const ComicCard({super.key, required this.comic});

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
                    SizedBox(
                      width: 170,
                      child: Text(
                        comic['title'],
                        style: const TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Image(
                      image: NetworkImage(
                        comic['thumbnail']['path'] +
                            '.' +
                            comic['thumbnail']['extension'],
                      ),
                      height: 200,
                      width: 250,
                    )
                  ]),
            )));
  }
}
