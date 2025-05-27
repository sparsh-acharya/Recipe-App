import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';
import 'package:recipe_app/features/recipe_selection/domain/entity/recipe_list_enttity.dart';
import 'package:recipe_app/features/recipe_selection/domain/usecase/get_recipe_by_ingredients_usecase.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final Usecase usecase;

  RecipeListBloc({required this.usecase}) : super(RecipeListInitial()) {
    on<FetchRecipesByIngredientsEvent>(_onFetchRecipesByIngredients);
  }

  Future<void> _onFetchRecipesByIngredients(
    FetchRecipesByIngredientsEvent event,
    Emitter<RecipeListState> emit,
  ) async {
    emit(RecipeListLoading());

    final result = await usecase(
      RecipeParams(
        ingredients: event.selectedIngredients.map((e) => e.name).toList(),
      ),
    );

    result.fold(
      (failure) => emit(RecipeListError(failure.message)),
      (recipes) => emit(RecipeListLoaded(recipes)),
    );
  }
}
