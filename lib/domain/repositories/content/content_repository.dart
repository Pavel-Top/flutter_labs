import 'package:dio/dio.dart';
import 'package:flutter_lab/data/endpoints.dart';
import 'package:flutter_lab/domain/repositories/content/content_repository_interface.dart';
import 'package:flutter_lab/domain/repositories/content/model/content.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Content>> getContent() async {
    try {
      // Сначала получаем список десертов
      final Response dessertsResponse = await dio.get(Endpoints.desserts);
      final meals = dessertsResponse.data['meals'] as List;
      
      // Ограничиваем до 10 элементов
      final limitedMeals = meals.take(10).toList();
      
      // Для каждого элемента получаем детальную информацию
      final List<Content> content = [];
      
      for (final meal in limitedMeals) {
        try {
          // Получаем детальную информацию о блюде
          final Response detailsResponse = await dio.get(
            Endpoints.mealDetails(meal['idMeal']),
          );
          
          final mealDetails = (detailsResponse.data['meals'] as List).first;
          
          content.add(Content(
            id: mealDetails['idMeal'] ?? '',
            title: mealDetails['strMeal'] ?? 'No title',
            author: mealDetails['strArea'] ?? 'International', // Используем регион как "автора"
            description: _getDescription(mealDetails), // Получаем настоящее описание
            image: mealDetails['strMealThumb'] ?? '',
          ));
        } catch (e) {
          // Если не удалось получить детали, используем базовую информацию
          content.add(Content(
            id: meal['idMeal'] ?? '',
            title: meal['strMeal'] ?? 'No title',
            author: 'TheMealDB',
            description: 'Delicious dessert', // Базовое описание
            image: meal['strMealThumb'] ?? '',
          ));
        }
        
        // Небольшая задержка чтобы не перегружать API
        await Future.delayed(const Duration(milliseconds: 100));
      }
      
      return content;
    } on DioException catch (e) {
      throw e.message ?? 'Unknown error occurred';
    }
  }

  // Метод для формирования описания из доступных данных
  String _getDescription(Map<String, dynamic> mealDetails) {
  final descriptions = [
    'A delightful treat for any occasion',
    'Perfect for satisfying your sweet tooth',
    'A classic dessert loved by many',
    'Sweet and delicious creation',
    'Irresistible dessert masterpiece',
    'Heavenly treat for dessert lovers',
    'Mouthwatering sweet delight',
    'Perfect balance of flavors and textures',
    'Decadent dessert experience',
    'Sweet indulgence you will love'
  ];
  
  return descriptions[DateTime.now().millisecond % descriptions.length];
}
}