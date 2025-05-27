part of 'recipe_detail_bloc.dart';

sealed class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object> get props => [];
}

final class RecipeDetailInitialState extends RecipeDetailState {}

final class RecipeDataLoadingState extends RecipeDetailState {}

final class RecipeDataLoadedState extends RecipeDetailState {
  final RecipeDetailEntity detailEntity;

  const RecipeDataLoadedState(this.detailEntity);

  @override
  List<Object> get props => [detailEntity];
}

final class RecipeDataErrorState extends RecipeDetailState {
  final String message;

  const RecipeDataErrorState({required this.message});

   @override
  List<Object> get props => [message];
}
