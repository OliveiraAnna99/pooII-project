import 'package:flutter/material.dart';

class FavoriteService extends StatelessWidget {
  final dynamic personagem;
  final dynamic comic;
  const FavoriteService(
      {super.key, required this.personagem, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent,
      ),
    );
  }
}
