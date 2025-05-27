import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecipeListModel {
  int id;
  String title;
  String? image;
  int usedIngredientCount;
  int missedIngredientCount;
  int likes;
  RecipeListModel({
    required this.id,
    required this.title,
    this.image,
    required this.usedIngredientCount,
    required this.missedIngredientCount,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'usedIngredientCount': usedIngredientCount,
      'missedIngredientCount': missedIngredientCount,
      'likes': likes,
    };
  }

  factory RecipeListModel.fromMap(Map<String, dynamic> map) {
    return RecipeListModel(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      usedIngredientCount: map['usedIngredientCount'] as int,
      missedIngredientCount: map['missedIngredientCount'] as int,
      likes: map['likes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeListModel.fromJson(String source) => RecipeListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
