part of 'ing_checklist_bloc.dart';

sealed class IngChecklistState extends Equatable {
  const IngChecklistState();

  @override
  List<Object> get props => [];
}

final class IngChecklistInitialState extends IngChecklistState {}
final class IngChecklistLoadingState extends IngChecklistState {}

final class IngChecklistloadedState extends IngChecklistState {
  final List<IngChecklistEntity> ingredientList;
  final int totalIngredients;
  final int completedIngredients;

  const IngChecklistloadedState({
    required this.ingredientList,
    this.totalIngredients = 0,
    this.completedIngredients = 0,
  });

  @override
  List<Object> get props => [ingredientList, totalIngredients, completedIngredients];
}

final class IngChecklistErrorState extends IngChecklistState {
  final String message;

  const IngChecklistErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
