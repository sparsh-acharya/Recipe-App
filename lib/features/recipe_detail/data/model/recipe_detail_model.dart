// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecipeDetailModel {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final String sourceName;
  final String sourceUrl;
  final List<String> dishTypes;

  RecipeDetailModel({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.sourceName,
    required this.sourceUrl,
    required this.dishTypes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'readyInMinutes': readyInMinutes,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'dishTypes': dishTypes,
    };
  }

  factory RecipeDetailModel.fromMap(Map<String, dynamic> map) {
    return RecipeDetailModel(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      readyInMinutes: map['readyInMinutes'] as int,
      sourceName: map['sourceName'] ?? '',
      sourceUrl: map['sourceUrl'] as String,
      dishTypes: List<String>.from(map['dishTypes'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeDetailModel.fromJson(String source) =>
      RecipeDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
