import 'package:flutter/material.dart';

void main() {
  MaterialApp app = MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.red, 
      fontFamily: 'Poppins'
    ),
    
    home: Scaffold(
      appBar: AppBar(title: Text("Meu app")),
      body: Center(
        child: Column(
          children: [
            Text("Iniciando...",style: TextStyle(fontSize: 13, height: 1.5)), // Define a altura desejada para o espaçamento entre as linhas
            Text("Carregando...", style: TextStyle(fontSize:13, height: 1.5)),
            Text("Terminando...", style: TextStyle(fontSize:13, height: 1.5)),
            Image.network("https://pbs.twimg.com/media/FlvQdmhWYAAjbL3.jpg"),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //centralizando os botões
        children: [
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.home),
          ),
           Spacer(),
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.favorite),
          ),
           Spacer(),
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            iconSize: 38, // Define o tamanho do ícone
            icon: Icon(
              Icons.search,
            ),
          ),
           Spacer(),
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.notifications),
          ),
           Spacer(),
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    ),
  );

  runApp(app);
}
