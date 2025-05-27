import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/recipe_selection/data/repo/recipe_repo_impl.dart';
import 'package:recipe_app/features/recipe_selection/domain/entity/recipe_list_enttity.dart';
import 'package:recipe_app/features/recipe_selection/domain/repo/recipe_repo.dart';

class GetRecipeByIngredientsUsecase
    implements Usecase<List<RecipeListEntity>, RecipeParams> {
  final RecipeRepo repo;

  GetRecipeByIngredientsUsecase({required this.repo});

  @override
  Future<Either<Failure, List<RecipeListEntity>>> call(RecipeParams params) async {
    return await repo.fetchRecipesByIngredients(params.ingredients);
  }
}

class RecipeParams {
  final List<String> ingredients;

  RecipeParams({required this.ingredients});
}
