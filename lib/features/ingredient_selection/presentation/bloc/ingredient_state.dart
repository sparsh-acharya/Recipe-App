part of 'ingredient_bloc.dart';

sealed class IngredientState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IngredientInitial extends IngredientState {}

class IngredientLoading extends IngredientState {}

class IngredientLoaded extends IngredientState {
  final List<IngredientEntity> ingredients;
  final Set<IngredientEntity> selectedIngredients;

  IngredientLoaded({
    required this.ingredients,
    this.selectedIngredients = const {},
  });

  IngredientLoaded copyWith({
    List<IngredientEntity>? ingredients,
    Set<IngredientEntity>? selectedIngredients,
  }) {
    return IngredientLoaded(
      ingredients: ingredients ?? this.ingredients,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
    );
  }

  @override
  List<Object?> get props => [ingredients, selectedIngredients];
}

class IngredientError extends IngredientState {
  final String message;
  IngredientError(this.message);

  @override
  List<Object?> get props => [message];
}
