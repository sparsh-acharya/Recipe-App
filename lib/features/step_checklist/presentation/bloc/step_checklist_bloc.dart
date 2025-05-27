import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/step_checklist/domain/entity/step_checklist_entity.dart';
import 'package:recipe_app/features/step_checklist/domain/usecase/fetch_steps_by_id_usecase.dart';

part 'step_checklist_event.dart';
part 'step_checklist_state.dart';

class StepChecklistBloc extends Bloc<StepChecklistEvent, StepChecklistState> {
  final FetchStepsByIdUsecase usecase;
  StepChecklistBloc({required this.usecase}) : super(StepChecklistInitialState()) {
    on<FetchStepsByIdEvent>(_fetchStepsByIdEventFunc);
    on<ToggleStepChecklistEvent>(_toggleStepChecklistEventFunc);
  }

  Future<void> _fetchStepsByIdEventFunc(
    FetchStepsByIdEvent event,
    Emitter<StepChecklistState> emit,
  ) async {
    emit(StepChecklistLoadingState());
    final result = await usecase(event.id);
    result.fold(
      (failure) => emit(StepChecklistErrorState(message: failure.message)),
      (steps) => emit(
        StepChecklistLoadedState(
          steps: steps,
          totalSteps: steps.length,
          completedSteps: 0,
        ),
      ),
    );
  }

  FutureOr<void> _toggleStepChecklistEventFunc(
    ToggleStepChecklistEvent event,
    Emitter<StepChecklistState> emit,
  ) {
    if (state is StepChecklistLoadedState) {
      final currentState = state as StepChecklistLoadedState;
      final updatedList = List<StepChecklistEntity>.from(currentState.steps);

      updatedList[event.index] = updatedList[event.index].copyWith(
        isChecked: !updatedList[event.index].isChecked,
      );
      final completed = updatedList.where((list) => list.isChecked).length;

      emit(
        StepChecklistLoadedState(
          steps: updatedList,
          totalSteps: updatedList.length,
          completedSteps: completed,
        ),
      );
    }
  }
}
