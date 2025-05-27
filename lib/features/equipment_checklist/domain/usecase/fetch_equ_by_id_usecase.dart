import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/equipment_checklist/domain/entity/equ_checklist_entity.dart';
import 'package:recipe_app/features/equipment_checklist/domain/repo/equ_checklist_repo.dart';

class FetchEquByIdUsecase extends Usecase<List<EquChecklistEntity>, int> {
  final EquChecklistRepo repo;

  FetchEquByIdUsecase({required this.repo});
  @override
  Future<Either<Failure, List<EquChecklistEntity>>> call(int id) async {
    return await repo.fetchEquById(id);
  }
}
