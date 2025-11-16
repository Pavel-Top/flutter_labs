import 'package:dio/dio.dart';
//import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:flutter_lab/di/di.dart';

void setUpDio() {
  dio.options.baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
  ));
}