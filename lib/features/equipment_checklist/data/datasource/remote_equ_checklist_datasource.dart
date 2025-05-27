import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/core/errors/failure.dart';
import 'package:recipe_app/features/equipment_checklist/data/datasource/equ_checklist_datasource.dart';
import 'package:recipe_app/features/equipment_checklist/data/model/equ_checklist_model.dart';

class RemoteEquChecklistDatasource extends EquChecklistDatasource {
  final Dio _dio = Dio();

  @override
  Future<Either<Failure, List<EquChecklistModel>>> fetchEquById(int id) async {
    final String baseUrl =
        'https://api.spoonacular.com/recipes/$id/equipmentWidget.json';
    final String apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {'apiKey': apiKey},
      );

      List<EquChecklistModel> list = [];
      final jsondata = response.data['equipment'];

      for (var map in jsondata) {
        list.add(EquChecklistModel.fromMap(map));
      }

      return right(list);
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }

  }
}
