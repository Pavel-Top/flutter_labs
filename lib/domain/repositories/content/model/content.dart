import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  @JsonKey(name: 'idMeal') // Добавь это, т.к. TheMealDB использует 'idMeal'
  final String id;
  @JsonKey(name: 'strMeal') // Добавь это, т.к. TheMealDB использует 'strMeal'
  final String title;
  final String author;
  final String description;
  @JsonKey(name: 'strMealThumb') // Добавь это, т.к. TheMealDB использует 'strMealThumb'
  final String image;

  Content({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
  });

  factory Content.fromJson(Map<String, dynamic> json) => 
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}