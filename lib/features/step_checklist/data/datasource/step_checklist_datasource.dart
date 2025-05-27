import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/step_checklist/data/model/step_checklist_model.dart';

abstract class StepChecklistDatasource {
  Future<Either<Failure,List<StepChecklistModel>>> fetchStepsById(int id);

}
