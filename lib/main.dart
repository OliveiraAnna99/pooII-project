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
          ElevatedButton(
            onPressed: () {
              // Ação do botão 1
            },
            child: Text("Botão 1"),
          ),
          ElevatedButton(
            onPressed: () {
              // Ação do botão 2
            },
            child: Text("Botão 2"),
          ),
          ElevatedButton(
            onPressed: () {
              // Ação do botão 3
            },
            child: Text("Botão 3"),
          ),
        ],
      ),
    ),
  );

  runApp(app);
}
