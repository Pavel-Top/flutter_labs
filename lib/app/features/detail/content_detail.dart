import 'package:json_annotation/json_annotation.dart';

part 'content_detail.g.dart';

@JsonSerializable()
class ContentDetail {
  final String id;
  final String title;
  final String category;
  final String area;
  final String instructions;
  final String image;
  final String? tags;
  final String? video;

  ContentDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
    this.tags,
    this.video,
  });

  factory ContentDetail.fromJson(Map<String, dynamic> json) => 
      _$ContentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailToJson(this);
}