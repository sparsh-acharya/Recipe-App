import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_selection/domain/entity/recipe_list_enttity.dart';

abstract class RecipeRepo {
  Future<Either<Failure, List<RecipeListEntity>>> fetchRecipesByIngredients(List<String> ingredients);
}
