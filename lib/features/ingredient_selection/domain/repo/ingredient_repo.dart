import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';

abstract class IngredientRepo {
  Future<Either<Failure, List<IngredientEntity>>> getIngredients();
}
