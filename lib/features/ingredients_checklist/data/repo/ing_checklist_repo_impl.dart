import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredients_checklist/data/datasource/ing_checklist_datasource.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/entity/ing_checklist_entity.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/repo/ing_checklist_repo.dart';

class IngChecklistRepoImpl implements IngChecklistRepo {
  final IngChecklistDatasource datasource;

  IngChecklistRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<IngChecklistEntity>>> fetchIngredientsById(
    int id,
  ) async {
    final modelEither = await datasource.fetchIngredientsById(id);
    return modelEither.fold(
      (failure) => left(failure),
      (models) => right(
        models
            .map(
              (model) => IngChecklistEntity(
                name: model.name,
                value: model.value,
                unit: model.unit,
              ),
            )
            .toList(),
      ),
    );
  }
}
