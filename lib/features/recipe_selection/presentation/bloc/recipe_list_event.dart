part of 'recipe_list_bloc.dart';

sealed class RecipeListEvent extends Equatable {
  const RecipeListEvent();

  @override
  List<Object> get props => [];
}

class FetchRecipesByIngredientsEvent extends RecipeListEvent {
  final Set<IngredientEntity> selectedIngredients;

  const FetchRecipesByIngredientsEvent(this.selectedIngredients);

  @override
  List<Object> get props => [selectedIngredients];
}
