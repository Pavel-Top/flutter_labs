import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_lab/data/dio/set_up.dart';
import 'package:flutter_lab/app/features/home/bloc/home_bloc.dart';
//import 'package:flutter_lab/app/features/home/bloc/detail_bloc.dart';
import 'package:flutter_lab/domain/repositories/content/content_repository.dart';
import 'package:flutter_lab/domain/repositories/content/content_repository_interface.dart';
import 'package:flutter_lab/domain/repositories/content/content_detail_repository.dart';
import 'package:flutter_lab/domain/repositories/content/content_detail_repository_interface.dart';

final getIt = GetIt.instance;
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();
  
  // Home screen dependencies
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );
  getIt.registerSingleton(HomeBloc(getIt.get<ContentRepositoryInterface>()));
  
  // Detail screen dependencies
  getIt.registerSingleton<ContentDetailRepositoryInterface>(
    ContentDetailRepository(dio: dio),
  );
  // DetailBloc будем создавать для каждого экрана, так как он зависит от mealId
}