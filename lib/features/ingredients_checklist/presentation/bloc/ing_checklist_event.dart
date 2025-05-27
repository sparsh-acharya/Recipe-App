part of 'ing_checklist_bloc.dart';

sealed class IngChecklistEvent extends Equatable {
  const IngChecklistEvent();

  @override
  List<Object> get props => [];
}

class FetchIngredientsByIdEvent extends IngChecklistEvent {
  final int id;

  const FetchIngredientsByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ToggleIngChecklistEvent extends IngChecklistEvent {
  final int index;

  const ToggleIngChecklistEvent({required this.index});

  @override
  List<Object> get props => [index];
}
