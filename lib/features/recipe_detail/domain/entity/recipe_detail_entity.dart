class RecipeDetailEntity {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final String sourceName;
  final String sourceUrl;
  final List<String> dishTypes;

  RecipeDetailEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.sourceName,
    required this.sourceUrl,
    required this.dishTypes,
  });
}
