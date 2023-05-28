import 'package:flutter/material.dart';

void main() {
  MaterialApp app = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red),
    home: Scaffold(
      appBar: AppBar(title: Text("Meu app")),
      body: Center(
        child: Column(
          children: [
            Text(
              "Apenas começando...",
              style: TextStyle(fontSize: 10, height: 1.5),
              // Defina a altura desejada para o espaçamento entre as linhas
            ),
            Text("No meio..."),
            Text("Terminando..."),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            iconSize: 38, // Define o tamanho do ícone
            icon: Icon(
              Icons.search,
            ),
          ),
          
          IconButton(
            onPressed: () {
              // Ação do botão de ícone
            },
            icon: Icon(Icons.notifications),
          ),
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
