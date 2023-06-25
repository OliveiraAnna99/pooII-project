
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

