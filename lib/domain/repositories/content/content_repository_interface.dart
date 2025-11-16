import 'package:flutter_lab/domain/repositories/content/model/content.dart';

abstract interface class ContentRepositoryInterface {
  Future<List<Content>> getContent();
}