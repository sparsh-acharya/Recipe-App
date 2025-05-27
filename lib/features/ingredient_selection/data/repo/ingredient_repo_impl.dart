import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredient_selection/data/datasource/ingredient_datasource.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';
import 'package:recipe_app/features/ingredient_selection/domain/repo/ingredient_repo.dart';

class IngredientRepoImpl implements IngredientRepo {
  final IngredientDatasource datasource;

  IngredientRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<IngredientEntity>>> getIngredients() async {
    try {
      final modelsEither = await datasource.getIngredients();
      return modelsEither.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((model) => IngredientEntity(
          name: model.name,
          category: model.category,
        )).toList()),
      );
    } catch (e) {
      return Left(CacheFailure('Failed to load ingredients: $e'));
    }
  }
}
