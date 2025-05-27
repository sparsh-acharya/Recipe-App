import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/equipment_checklist/domain/entity/equ_checklist_entity.dart';

abstract class EquChecklistRepo {
  Future <Either<Failure,List<EquChecklistEntity>>> fetchEquById(int id);

}
