import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_selection/data/model/recipe_list_model.dart';


abstract class RecipeDatasource {
  Future<Either<Failure, List<RecipeListModel>>> fetchRecipesByIngredients(List<String> ingredients);
}
