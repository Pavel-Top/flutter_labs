import 'package:flutter/material.dart';
import 'di/di.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  // Обработка ошибок Flutter без talker
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    
  };
  
  runApp(const MyApp());
}