import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_detail/data/datasources/recipe_detail_datasource.dart';
import 'package:recipe_app/features/recipe_detail/domain/entity/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_detail/domain/repo/recipe_detail_repo.dart';

class RecipeDetailRepoImpl implements RecipeDetailRepo {
  final RecipeDetailDatasource datasource;

  RecipeDetailRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, RecipeDetailEntity>> fetchDetailsById(int id) async {
    final modelEither = await datasource.fetchDetailsById(id);
    return modelEither.fold(
      (failure) => left(failure),
      (model) => right(
        RecipeDetailEntity(
          id: model.id,
          title: model.title,
          image: model.image,
          readyInMinutes: model.readyInMinutes,
          sourceName: model.sourceName,
          sourceUrl: model.sourceUrl,
          dishTypes: model.dishTypes,
        ),
      ),
    );
  }
}
