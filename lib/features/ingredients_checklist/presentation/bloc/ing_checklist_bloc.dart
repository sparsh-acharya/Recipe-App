import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/entity/ing_checklist_entity.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/usecase/fetch_ingredients_by_id.dart';

part 'ing_checklist_event.dart';
part 'ing_checklist_state.dart';

class IngChecklistBloc extends Bloc<IngChecklistEvent, IngChecklistState> {
  final FetchIngredientsByIdUsecase usecase;
  IngChecklistBloc({required this.usecase})
    : super(IngChecklistInitialState()) {
    on<FetchIngredientsByIdEvent>(_fetchIngByIdEventFunc);
    on<ToggleIngChecklistEvent>(_toggleIngredientEventFunc);
  }

  Future<void> _fetchIngByIdEventFunc(
    FetchIngredientsByIdEvent event,
    Emitter<IngChecklistState> emit,
  ) async {
    emit(IngChecklistLoadingState());
    final result = await usecase(event.id);
    result.fold(
      (failure) => emit(IngChecklistErrorState(message: failure.message)),
      (ingredintsList) => emit(IngChecklistloadedState(
        ingredientList: ingredintsList,
        totalIngredients: ingredintsList.length,
        completedIngredients: 0,
      )),
    );
  }

  void _toggleIngredientEventFunc(
    ToggleIngChecklistEvent event,
    Emitter<IngChecklistState> emit,
  ) {
    if (state is IngChecklistloadedState) {
      final currentState = state as IngChecklistloadedState;
      final updatedList = List<IngChecklistEntity>.from(currentState.ingredientList);

      // Toggle the checked state of the ingredient at the given index
      updatedList[event.index] = updatedList[event.index].copyWith(
        isChecked: !updatedList[event.index].isChecked,
      );

      // Count completed ingredients
      final completedCount = updatedList.where((ing) => ing.isChecked).length;

      emit(IngChecklistloadedState(
        ingredientList: updatedList,
        totalIngredients: currentState.totalIngredients,
        completedIngredients: completedCount,
      ));
    }
  }
}
