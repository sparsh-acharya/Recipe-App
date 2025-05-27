part of 'step_checklist_bloc.dart';

sealed class StepChecklistState extends Equatable {
  const StepChecklistState();

  @override
  List<Object> get props => [];
}

final class StepChecklistInitialState extends StepChecklistState {}

final class StepChecklistLoadingState extends StepChecklistState {}

final class StepChecklistLoadedState extends StepChecklistState {
  final List<StepChecklistEntity> steps;
  final int totalSteps;
  final int completedSteps;

  const StepChecklistLoadedState({
    required this.steps,
    this.totalSteps = 0,
    this.completedSteps = 0,
  });
  @override
  List<Object> get props => [steps, totalSteps, completedSteps];
}

final class StepChecklistErrorState extends StepChecklistState {
  final String message;

  const StepChecklistErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
