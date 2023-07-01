import 'package:flutter/material.dart';

class DetailComicPage extends StatelessWidget {
  const DetailComicPage({super.key,required this.comic});

  final dynamic comic;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Comic'),
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
                    comic.title,
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
                  comic.image,
                  width: 200,
                  fit: BoxFit.contain,
                )),),
                if (comic.description == "") 
                const Text("Não possui descrição", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),)
                else
                Text(
                  'Descrição:\n ${comic.description}',
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

