import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/step_checklist/domain/entity/step_checklist_entity.dart';

abstract class StepChecklistRepo {

  Future<Either<Failure,List<StepChecklistEntity>>> fetchStepsById(int id);

}
