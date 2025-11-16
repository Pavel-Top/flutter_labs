import 'package:dio/dio.dart';
import 'package:flutter_lab/app/features/detail/content_detail.dart';
import 'package:flutter_lab/data/endpoints.dart';
import 'package:flutter_lab/domain/repositories/content/content_detail_repository_interface.dart';

class ContentDetailRepository implements ContentDetailRepositoryInterface {
  ContentDetailRepository({required this.dio});

  final Dio dio;

  @override
  Future<ContentDetail> getContentDetail(String id) async {
    try {
      final Response response = await dio.get(Endpoints.mealDetails(id));
      
      final meals = response.data['meals'] as List;
      if (meals.isEmpty) {
        throw Exception('Meal not found');
      }
      
      final mealData = meals.first;
      
      return ContentDetail(
        id: mealData['idMeal'] ?? '',
        title: mealData['strMeal'] ?? 'No title',
        category: mealData['strCategory'] ?? '',
        area: mealData['strArea'] ?? '',
        instructions: mealData['strInstructions'] ?? '',
        image: mealData['strMealThumb'] ?? '',
        tags: mealData['strTags'],
        video: mealData['strYoutube'],
      );
    } on DioException catch (e) {
      throw e.message ?? 'Failed to load meal details';
    }
  }
}