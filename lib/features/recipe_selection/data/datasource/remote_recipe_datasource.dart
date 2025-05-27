import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_selection/data/datasource/recipe_datasource.dart';
import 'package:recipe_app/features/recipe_selection/data/model/recipe_list_model.dart';


class RemoteRecipeDatasource implements RecipeDatasource {
  final Dio _dio = Dio();

  @override
  Future<Either<Failure, List<RecipeListModel>>> fetchRecipesByIngredients(List<String> ingredients) async {
    final String baseUrl =
        'https://api.spoonacular.com/recipes/findByIngredients';
    final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';   //todo: move to env
    try {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'apiKey': apiKey,
        'ranking': 1,
        'number': 20,
        'ingredients': ingredients.join(','),
      },
    );

    final List<dynamic> jsonData = response.data;
    final List<RecipeListModel> recipes = jsonData.map((recipe) => RecipeListModel(
      id: recipe['id'] as int,
      title: recipe['title'] as String,
      image: recipe['image'] as String?,
      usedIngredientCount: recipe['usedIngredientCount'] as int,
      missedIngredientCount: recipe['missedIngredientCount'] as int,
      likes: recipe['likes'] as int,
    )).toList();
    return right(recipes);
  } catch (e) {
    return left(ServerFailure(e.toString()));

  }
  }
}
