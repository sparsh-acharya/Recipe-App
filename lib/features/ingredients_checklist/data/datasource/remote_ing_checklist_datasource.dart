import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredients_checklist/data/datasource/ing_checklist_datasource.dart';
import 'package:recipe_app/features/ingredients_checklist/data/model/ing_checklist_model.dart';

class RemoteIngChecklistDatasource implements IngChecklistDatasource {
  final Dio _dio = Dio();

  @override
  Future<Either<Failure, List<IngChecklistModel>>> fetchIngredientsById(
    int id,
  ) async {
    final String baseUrl =
        'https://api.spoonacular.com/recipes/$id/ingredientWidget.json';
    final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {'apiKey': apiKey},
      );

      List<IngChecklistModel> list = [];
      final jsondata = response.data['ingredients'];

      for (var map in jsondata) {
        list.add(IngChecklistModel.fromMap(map));
      }

      return right(list);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }
}
