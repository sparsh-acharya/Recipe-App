import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredients_checklist/domain/entity/ing_checklist_entity.dart';

abstract class IngChecklistRepo {
  Future<Either<Failure,List<IngChecklistEntity>>> fetchIngredientsById(int id);
}
