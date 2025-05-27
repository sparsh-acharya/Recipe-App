part of 'ingredient_bloc.dart';

@immutable
sealed class IngredientEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadIngredientsEvent extends IngredientEvent {}

class ToggleIngredientEvent extends IngredientEvent {
  final IngredientEntity ingredient;

  ToggleIngredientEvent(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class ClearSelectionEvent extends IngredientEvent {}
