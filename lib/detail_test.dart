import 'package:dio/dio.dart';

final Dio _dio = Dio();
final int id = 716429;
final String baseUrl =
    'https://api.spoonacular.com/recipes/$id/information?';
final String _apiKey = '2538664de5a34dee8ff58850222d827b';

Future<void> fetchRecipes() async {
  try {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'apiKey': _apiKey,
        // comma-separated
      },
    );


    final Map<String,dynamic> js = response.data;
    print(js.runtimeType);
    print('------------------------------------------------------------');
    print(js['id']); //int
    print(js['title']); //string
    print(js['image']); //strin url
    print(js['readyInMinutes']); //int
    print(js['sourceName']);//string
    print(js['sourceUrl']);//string url
    print(js['dishTypes']);//list<string>


  } catch (e) {
    print('Error fetching recipes: $e');
  }
}

void main() {
  fetchRecipes();
}
