// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecipeListEntity {
  int id;
  String title;
  String? image;
  int usedIngredientCount;
  int missedIngredientCount;
  int likes;
  RecipeListEntity({
    required this.id,
    required this.title,
    this.image,
    required this.usedIngredientCount,
    required this.missedIngredientCount,
    required this.likes,
  });
}
