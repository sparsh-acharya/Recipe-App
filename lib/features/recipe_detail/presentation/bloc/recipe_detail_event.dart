part of 'recipe_detail_bloc.dart';

sealed class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailsByIdEvent extends RecipeDetailEvent {
  final int id;

  const FetchDetailsByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}
