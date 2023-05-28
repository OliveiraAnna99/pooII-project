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
                 style: TextStyle(height: 5, fontSize: 10),
              
              ),

              Text("No meio..."),

              Text("Terminando...")              

            ]

          )          

        ),

        bottomNavigationBar: Text("Botão 1"),

      ));

  runApp(app);

}