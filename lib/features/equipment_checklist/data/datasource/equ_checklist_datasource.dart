import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/equipment_checklist/data/model/equ_checklist_model.dart';

abstract class EquChecklistDatasource {
  Future<Either<Failure,List<EquChecklistModel>>> fetchEquById(int id);
}
