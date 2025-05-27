import 'package:dio/dio.dart';
import 'package:recipe_app/features/recipe_selection/domain/entity/recipe_list_enttity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StepChecklistModel {
  int? stepNo;
  final String stepTask;

  StepChecklistModel({this.stepNo, required this.stepTask});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'stepNo': stepNo, 'stepTask': stepTask};
  }

  @override
  String toString() => '$stepNo - $stepTask';

  factory StepChecklistModel.fromMap(Map<String, dynamic> map) {
    return StepChecklistModel(
      stepNo: map['stepNo'] as int,
      stepTask: map['stepTask'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StepChecklistModel.fromJson(String source) =>
      StepChecklistModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

final Dio _dio = Dio();
final int id = 324694;
final String baseUrl =
    'https://api.spoonacular.com/recipes/$id/analyzedInstructions?';
final String apiKey = '2538664de5a34dee8ff58850222d827b';

Future<List<StepChecklistModel>> fetchRecipes() async {
  try {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'apiKey': apiKey,
        'stepBreakdown': true,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> instructions = response.data;
      late List<StepChecklistModel> allSteps;
      int stepCounter = 1;  // Initialize counter for continuous numbering

      // Process all instruction sets
      for (var instruction in instructions) {
        final List<dynamic> steps = instruction['steps'];
        allSteps = steps.map((step) {
          return StepChecklistModel(
            stepNo: stepCounter++,  // Use and increment the counter
            stepTask: step['step'],
          );
        }).toList();

      }

      return allSteps;
    }
    return [];
  } catch (e) {
    print('Error fetching recipes: $e');
    return [];
  }
}

void main() async {
  final steps = await fetchRecipes();
  for (var step in steps) {
    print(step.toString());
  }
}
