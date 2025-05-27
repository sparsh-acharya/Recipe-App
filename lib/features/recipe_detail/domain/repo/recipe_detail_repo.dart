import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_detail/domain/entity/recipe_detail_entity.dart';

abstract class RecipeDetailRepo {
  Future<Either<Failure,RecipeDetailEntity>> fetchDetailsById(int id);
}
