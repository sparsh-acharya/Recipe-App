import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/step_checklist/data/datasource/step_checklist_datasource.dart';
import 'package:recipe_app/features/step_checklist/domain/entity/step_checklist_entity.dart';
import 'package:recipe_app/features/step_checklist/domain/repo/step_checklist_repo.dart';

class StepChecklistRepoImpl extends StepChecklistRepo {
  final StepChecklistDatasource datasource;

  StepChecklistRepoImpl({required this.datasource});
  @override
  Future<Either<Failure, List<StepChecklistEntity>>> fetchStepsById(
    int id,
  ) async {
    final modelEither = await datasource.fetchStepsById(id);
    return modelEither.fold(
      (failure) => left(failure),
      (stepModel) => right(
        stepModel
            .map(
              (element) => StepChecklistEntity(
                stepNo: element.stepNo,
                stepTask: element.stepTask,
              ),
            )
            .toList(),
      ),
    );
  }
}
