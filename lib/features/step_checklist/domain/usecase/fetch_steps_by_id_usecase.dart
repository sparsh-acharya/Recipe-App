import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/step_checklist/domain/entity/step_checklist_entity.dart';
import 'package:recipe_app/features/step_checklist/domain/repo/step_checklist_repo.dart';

class FetchStepsByIdUsecase extends Usecase<List<StepChecklistEntity>, int> {
  final StepChecklistRepo repo;

  FetchStepsByIdUsecase({required this.repo});
  @override
  Future<Either<Failure, List<StepChecklistEntity>>> call(int id) {
    return repo.fetchStepsById(id);
  }
}
