
class Comic {
  final int id;
  final String title;
  final String description;
  final String image;
  bool isFavorite;

  Comic({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });
}



class Personagem {
  final int id;
  final String title;
  final String description;
  final String image;
  bool isFavorite;

  Personagem({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });
}

