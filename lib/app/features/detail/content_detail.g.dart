// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentDetail _$ContentDetailFromJson(Map<String, dynamic> json) =>
    ContentDetail(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      area: json['area'] as String,
      instructions: json['instructions'] as String,
      image: json['image'] as String,
      tags: json['tags'] as String?,
      video: json['video'] as String?,
    );

Map<String, dynamic> _$ContentDetailToJson(ContentDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'area': instance.area,
      'instructions': instance.instructions,
      'image': instance.image,
      'tags': instance.tags,
      'video': instance.video,
    };
