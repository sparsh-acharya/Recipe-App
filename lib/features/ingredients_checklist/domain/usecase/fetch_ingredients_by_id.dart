import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/entity/ing_checklist_entity.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/repo/ing_checklist_repo.dart';

class FetchIngredientsByIdUsecase extends Usecase<List<IngChecklistEntity>,int> {
  final IngChecklistRepo repo;

  FetchIngredientsByIdUsecase({required this.repo});
  @override
  Future<Either<Failure, List<IngChecklistEntity>>> call(int id) async {
    return await repo.fetchIngredientsById(id);

  }
}
