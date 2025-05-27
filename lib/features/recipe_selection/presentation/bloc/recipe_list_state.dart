part of 'recipe_list_bloc.dart';

sealed class RecipeListState extends Equatable {
  const RecipeListState();

  @override
  List<Object> get props => [];
}

final class RecipeListInitial extends RecipeListState {}

final class RecipeListLoading extends RecipeListState {}

final class RecipeListLoaded extends RecipeListState {
  final List<RecipeListEntity> recipes;

  const RecipeListLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

final class RecipeListError extends RecipeListState {
  final String message;

  const RecipeListError(this.message);

  @override
  List<Object> get props => [message];
}
