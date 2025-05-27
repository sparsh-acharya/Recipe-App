// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IngredientModel {
  final String name;
  final String category;

  IngredientModel({required this.name, required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      name: map['name'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IngredientModel.fromJson(String source) => IngredientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
