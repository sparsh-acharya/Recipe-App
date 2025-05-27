class EquChecklistEntity {
  final String name;
  final bool isChecked;

  EquChecklistEntity({required this.name, this.isChecked = false});

  EquChecklistEntity copyWith({String? name, bool? isChecked}) {
    return EquChecklistEntity(
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
