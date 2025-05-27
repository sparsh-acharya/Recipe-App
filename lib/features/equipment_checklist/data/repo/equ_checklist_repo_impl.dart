import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/equipment_checklist/data/datasource/equ_checklist_datasource.dart';
import 'package:recipe_app/features/equipment_checklist/domain/entity/equ_checklist_entity.dart';
import 'package:recipe_app/features/equipment_checklist/domain/repo/equ_checklist_repo.dart';

class EquChecklistRepoImpl extends EquChecklistRepo {
  final EquChecklistDatasource datasource;

  EquChecklistRepoImpl({required this.datasource});
  @override
  Future<Either<Failure, List<EquChecklistEntity>>> fetchEquById(int id) async {
    final modelEither = await datasource.fetchEquById(id);
    return modelEither.fold(
      (failure) => left(failure),
      (models) => right(
        models.map((model) => EquChecklistEntity(name: model.name)).toList(),
      ),
    );
  }
}
