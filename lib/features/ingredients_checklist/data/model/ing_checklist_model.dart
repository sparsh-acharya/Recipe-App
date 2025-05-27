// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IngChecklistModel {
  final String name;
  final double value;
  final String unit;

  IngChecklistModel({
    required this.name,
    required this.value,
    required this.unit,
  });

  @override
  String toString() =>
      'IngChecklistModel(name: $name, value: $value, unit: $unit)';

  IngChecklistModel copyWith({String? name, double? value, String? unit}) {
    return IngChecklistModel(
      name: name ?? this.name,
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'value': value, 'unit': unit};
  }

  factory IngChecklistModel.fromMap(Map<String, dynamic> map) {
    return IngChecklistModel(
      name: map['name'] as String,
      value: map['amount']['metric']['value'] as double,
      unit: map['amount']['metric']['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IngChecklistModel.fromJson(String source) =>
      IngChecklistModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
