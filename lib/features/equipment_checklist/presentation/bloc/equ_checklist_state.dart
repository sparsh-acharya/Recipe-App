part of 'equ_checklist_bloc.dart';

sealed class EquChecklistState extends Equatable {
  const EquChecklistState();

  @override
  List<Object> get props => [];
}

final class EquChecklistInitialState extends EquChecklistState {}

final class EquChecklistLoadingState extends EquChecklistState {}

final class EquChecklistLoadedState extends EquChecklistState {
  final List<EquChecklistEntity> equipmentList;
  final int total;
  final int completed;

  const EquChecklistLoadedState({
    required this.equipmentList,
    this.total = 0,
    this.completed = 0,
  });

  @override
  List<Object> get props => [equipmentList, total, completed];
}

final class EquChecklistErrorState extends EquChecklistState {
  final String message;

  const EquChecklistErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
