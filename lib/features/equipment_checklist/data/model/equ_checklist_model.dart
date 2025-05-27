// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EquChecklistModel {
  final String name;


  EquChecklistModel({required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory EquChecklistModel.fromMap(Map<String, dynamic> map) {
    return EquChecklistModel(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EquChecklistModel.fromJson(String source) => EquChecklistModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
