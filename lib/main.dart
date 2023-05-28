import 'package:flutter/material.dart';

void main() {

    MaterialApp app = MaterialApp(

      theme: ThemeData(primarySwatch: Colors.deepPurple),

      home: Scaffold(

        appBar: AppBar(title: Text("Meu app")),

        body: Text("Apenas começando..."),

        bottomNavigationBar: Text("Botão 1"),

      ));


  runApp(app);


}