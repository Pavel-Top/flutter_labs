import 'package:flutter_lab/app/features/detail/content_detail.dart';

abstract interface class ContentDetailRepositoryInterface {
  Future<ContentDetail> getContentDetail(String id);
}