import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredients_checklist/data/model/ing_checklist_model.dart';

abstract class IngChecklistDatasource {

  Future<Either<Failure,List<IngChecklistModel>>> fetchIngredientsById(int id);

}
