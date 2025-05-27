import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final Usecase useCase;

  IngredientBloc({ required this.useCase}) : super(IngredientInitial()) {
    on<LoadIngredientsEvent>((event, emit) async {
      emit(IngredientLoading());
      final result = await useCase(NoParams());

      result.fold(
        (failure) => emit(IngredientError(failure.message)),
        (ingredients) => emit(IngredientLoaded(ingredients: ingredients)),
      );
    });

    on<ToggleIngredientEvent>((event, emit) {
      if (state is IngredientLoaded) {
        final currentState = state as IngredientLoaded;
        final newSelection = Set<IngredientEntity>.from(currentState.selectedIngredients);

        if (newSelection.contains(event.ingredient)) {
          newSelection.remove(event.ingredient);
        } else {
          newSelection.add(event.ingredient);
        }

        emit(currentState.copyWith(selectedIngredients: newSelection));
      }
    });

    on<ClearSelectionEvent>((event, emit) {
      if (state is IngredientLoaded) {
        final currentState = state as IngredientLoaded;
        emit(currentState.copyWith(selectedIngredients: {}));
      }
    });
  }
}
