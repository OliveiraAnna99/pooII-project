import 'package:flutter/material.dart';

void main() {

  MaterialApp app = MaterialApp(

      title: 'Primeiro App',

      theme: ThemeData(primarySwatch: Colors.deepPurple),

      home: Scaffold(

        appBar: AppBar(title: Text("Meu app")),

        body: Center(

          child: Text("Apenas começando...")

        ),

        bottomNavigationBar: Text("Botão 1"),

      ));

  runApp(app);

}