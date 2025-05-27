import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/ingredient_selection/data/datasource/ingredient_datasource.dart';
import 'package:recipe_app/features/ingredient_selection/data/model/ingredient_model.dart';

class LocalIngredientDatasource implements IngredientDatasource {
  @override
  Future<Either<Failure, List<IngredientModel>>> getIngredients() async {
    try {
      final jsonString = await rootBundle.loadString(
        'lib/core/database/local/ingredients.json',
      );
      final jsonData = jsonDecode(jsonString);
      final List<dynamic> categories = jsonData['categories'];

      final ingredients = categories.expand((category) {
        final String categoryName = category['category'];
        final List<dynamic> items = category['data'];
        return items.map((item) => IngredientModel(
          name: item['name'],
          category: categoryName,
        ));
      }).toList();

      return right(ingredients);
    } on PlatformException catch (e) {
      return Left(CacheFailure('Failed to load JSON asset: ${e.message}'));
    } on FormatException catch (e) {
      return Left(CacheFailure('Invalid JSON format: ${e.message}'));
    } catch (e) {
      return Left(CacheFailure('Unknown error: ${e.toString()}'));
    }
  }
}
