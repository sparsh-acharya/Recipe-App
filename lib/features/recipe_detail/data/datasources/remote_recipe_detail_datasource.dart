import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/recipe_detail/data/datasources/recipe_detail_datasource.dart';
import 'package:recipe_app/features/recipe_detail/data/model/recipe_detail_model.dart';

class RemoteRecipeDetailDatasource implements RecipeDetailDatasource {
  final Dio _dio = Dio();

  @override
  Future<Either<Failure, RecipeDetailModel>> fetchDetailsById(int id) async {
    try {
      final String baseUrl =
          'https://api.spoonacular.com/recipes/$id/information?';
      final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';

      final response = await _dio.get(
        baseUrl,
        queryParameters: {'apiKey': apiKey},
      );
      final Map<String, dynamic> data = response.data;
      final RecipeDetailModel recipeDetail = RecipeDetailModel(
        id: data['id'] as int,
        title: data['title'] as String,
        image: data['image'] as String,
        readyInMinutes: data['readyInMinutes'] as int,
        sourceName: data['sourceName'] as String,
        sourceUrl: data['sourceUrl'] as String,
        dishTypes: List<String>.from(data['dishTypes'] ?? []),
      );
      return right(recipeDetail);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
