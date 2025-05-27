import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/features/recipe_detail/domain/entity/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_detail/domain/usecase/fetch_details_by_id.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final FetchDetailsById usecase;
  RecipeDetailBloc({required this.usecase}) : super(RecipeDetailInitialState()) {
    on<FetchDetailsByIdEvent>(_fetchDetailsByIdFunc);
  }
  Future<void> _fetchDetailsByIdFunc(
    FetchDetailsByIdEvent event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(RecipeDataLoadingState());
    final result = await usecase(event.id);
    result.fold(
      (failure) => emit(RecipeDataErrorState(message: failure.message)),
      (entity) => emit(RecipeDataLoadedState(entity)),
    );
  }
}
