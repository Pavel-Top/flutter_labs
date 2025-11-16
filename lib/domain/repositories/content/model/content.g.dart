// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  id: json['idMeal'] as String,
  title: json['strMeal'] as String,
  author: json['author'] as String,
  description: json['description'] as String,
  image: json['strMealThumb'] as String,
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'idMeal': instance.id,
  'strMeal': instance.title,
  'author': instance.author,
  'description': instance.description,
  'strMealThumb': instance.image,
};
