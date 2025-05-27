import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_detail/data/model/recipe_detail_model.dart';

abstract class RecipeDetailDatasource {
  Future<Either<Failure,RecipeDetailModel>> fetchDetailsById(int id);
}
