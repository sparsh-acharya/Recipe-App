import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/step_checklist/data/datasource/step_checklist_datasource.dart';
import 'package:recipe_app/features/step_checklist/data/model/step_checklist_model.dart';

class RemoteStepChecklistDatasource extends StepChecklistDatasource {
  final Dio _dio = Dio();
  @override
  Future<Either<Failure, List<StepChecklistModel>>> fetchStepsById(
    int id,
  ) async {
    final String baseUrl =
        'https://api.spoonacular.com/recipes/$id/analyzedInstructions?';
    final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'apiKey': apiKey,
          'stepBreakdown': true, // comma-separated
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> instructions = response.data;
        late List<StepChecklistModel> allStep;
        int stepCounter = 1; // Initialize counter for continuous numbering

        // Process all instruction sets
        for (var instruction in instructions) {
          final List<dynamic> steps = instruction['steps'];
          allStep =
              steps.map((step) {
                return StepChecklistModel(
                  stepNo: stepCounter++, // Use and increment the counter
                  stepTask: step['step'],
                );
              }).toList();
        }

        return Right(allStep);
      }
      return Left(
        ServerFailure('${response.statusCode} - ${response.statusMessage}'),
      );
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
