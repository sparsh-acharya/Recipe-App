class IngChecklistEntity {
  final String name;
  final double value;
  final String unit;
  final bool isChecked;

  IngChecklistEntity({
    required this.name,
    required this.value,
    required this.unit,
    this.isChecked = false,
  });

  IngChecklistEntity copyWith({
    String? name,
    double? value,
    String? unit,
    bool? isChecked,
  }) {
    return IngChecklistEntity(
      name: name ?? this.name,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  String toString() => '$name - $value $unit';
}
