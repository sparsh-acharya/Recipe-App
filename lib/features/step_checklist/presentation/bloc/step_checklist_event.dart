part of 'step_checklist_bloc.dart';

sealed class StepChecklistEvent extends Equatable {
  const StepChecklistEvent();

  @override
  List<Object> get props => [];
}

class FetchStepsByIdEvent extends StepChecklistEvent {
  final int id;

  const FetchStepsByIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class ToggleStepChecklistEvent extends StepChecklistEvent {
  final int index;

  const ToggleStepChecklistEvent({required this.index});
  @override
  List<Object> get props => [index];
}
