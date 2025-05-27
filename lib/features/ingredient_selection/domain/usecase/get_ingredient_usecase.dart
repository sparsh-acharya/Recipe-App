import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/ingredient_selection/domain/entity/ingredient_entity.dart';
import 'package:recipe_app/features/ingredient_selection/domain/repo/ingredient_repo.dart';

class GetIngredientUsecase extends Usecase<List<IngredientEntity>, NoParams> {
  final IngredientRepo repo;
  GetIngredientUsecase({required this.repo});

  @override
  Future<Either<Failure, List<IngredientEntity>>> call(NoParams params) {
    return repo.getIngredients();
  }
}
