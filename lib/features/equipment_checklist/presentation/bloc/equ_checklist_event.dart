part of 'equ_checklist_bloc.dart';

sealed class EquChecklistEvent extends Equatable {
  const EquChecklistEvent();

  @override
  List<Object> get props => [];
}

class FetchEquByIdEvent extends EquChecklistEvent{
  final int id;

  const FetchEquByIdEvent({required this.id});

  @override
  List<Object> get props => [id];

}

class ToggleEquChecklistEvent extends EquChecklistEvent{
  final int index;

  const ToggleEquChecklistEvent({required this.index});

  @override
  List<Object> get props => [index];

}
