import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/core/usecase/usecase.dart';
import 'package:recipe_app/features/recipe_detail/domain/entity/recipe_detail_entity.dart';
import 'package:recipe_app/features/recipe_detail/domain/repo/recipe_detail_repo.dart';

class FetchDetailsById extends Usecase<RecipeDetailEntity,int>{
  final RecipeDetailRepo repo;

  FetchDetailsById({required this.repo});
  @override
  Future<Either<Failure, RecipeDetailEntity>> call(int id) async {
    return await repo.fetchDetailsById(id);
  }
}
