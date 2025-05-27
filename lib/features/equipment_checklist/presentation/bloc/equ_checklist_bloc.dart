import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/features/equipment_checklist/domain/entity/equ_checklist_entity.dart';
import 'package:recipe_app/features/equipment_checklist/domain/usecase/fetch_equ_by_id_usecase.dart';
import 'package:recipe_app/features/ingredient_selection/presentation/bloc/ingredient_bloc.dart';

part 'equ_checklist_event.dart';
part 'equ_checklist_state.dart';

class EquChecklistBloc extends Bloc<EquChecklistEvent, EquChecklistState> {
  final FetchEquByIdUsecase usecase;
  EquChecklistBloc({required this.usecase})
    : super(EquChecklistInitialState()) {
    on<FetchEquByIdEvent>(_fetchEquByIdEventFunc);
    on<ToggleEquChecklistEvent>(_toggleEquChecklistEventFunc);
  }

  FutureOr<void> _fetchEquByIdEventFunc(
    FetchEquByIdEvent event,
    Emitter<EquChecklistState> emit,
  ) async {
    emit(EquChecklistLoadingState());
    final result = await usecase(event.id);
    result.fold(
      (failure) => emit(EquChecklistErrorState(message: failure.message)),
      (equipmentList) => emit(
        EquChecklistLoadedState(
          equipmentList: equipmentList,
          total: equipmentList.length,
          completed: 0,
        ),
      ),
    );
  }

  FutureOr<void> _toggleEquChecklistEventFunc(
    ToggleEquChecklistEvent event,
    Emitter<EquChecklistState> emit,
  ) async {
    if (state is EquChecklistLoadedState) {
      final currentState = state as EquChecklistLoadedState;
      final updatedList = List<EquChecklistEntity>.from(
        currentState.equipmentList,
      );
      updatedList[event.index] = updatedList[event.index].copyWith(
        isChecked: !updatedList[event.index].isChecked,
      );

      final completed = updatedList.where((equ) => equ.isChecked).length;
      emit(
        EquChecklistLoadedState(
          equipmentList: updatedList,
          total: updatedList.length,
          completed: completed,
        ),
      );
    }
  }
}
