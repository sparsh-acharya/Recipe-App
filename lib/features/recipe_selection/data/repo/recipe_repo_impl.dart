import 'package:dartz/dartz.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_selection/data/datasource/recipe_datasource.dart';

import 'package:recipe_app/features/recipe_selection/domain/entity/recipe_list_enttity.dart';
import 'package:recipe_app/features/recipe_selection/domain/repo/recipe_repo.dart';

class RecipeRepoImpl implements RecipeRepo {
  final RecipeDatasource datasource;

  RecipeRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<RecipeListEntity>>> fetchRecipesByIngredients(
    List<String> ingredients,
  ) async {
    final modelsEither = await datasource.fetchRecipesByIngredients(
      ingredients,
    );
    return modelsEither.fold(
      (failure) => Left(failure),
      (models) => Right(
        models
            .map(
              (model) => RecipeListEntity(
                id: model.id,
                title: model.title,
                image: model.image,
                usedIngredientCount: model.usedIngredientCount,
                missedIngredientCount: model.missedIngredientCount,
                likes: model.likes,
              ),
            )
            .toList(),
      ),
    );
  }
}
