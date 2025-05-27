class IngredientEntity {
  final String name;
  final String category;
  final bool isSelected;

  IngredientEntity({
    required this.name,
    required this.category,
    this.isSelected = false,
  });

  IngredientEntity copyWith({bool? isSelected}) {
    return IngredientEntity(
      category: category,
      name: name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
