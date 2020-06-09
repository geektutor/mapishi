class Recipe {
  final String image;
  final String title;
  final String about;
  final List description;

  Recipe({this.image, this.title, this.about, this.description});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      image: json['image'] as String,
      title: json['title'] as String,
      about: json['about'] as String,
      description: json['description'] as List,
    );
  }
}
