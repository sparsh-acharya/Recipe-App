import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredient_selection/data/model/ingredient_model.dart';

abstract class IngredientDatasource {
  Future<Either<Failure, List<IngredientModel>>> getIngredients();
}
