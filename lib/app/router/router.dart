import 'package:go_router/go_router.dart';
import 'package:flutter_lab/app/features/detail/detail_screen.dart';
import 'package:flutter_lab/app/features/home/home_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) {
          // Получаем mealId из extra параметров
          final mealId = state.extra as String;
          return DetailScreen(mealId: mealId);
        },
      ),
    ],
  );
}

final router = createRouter();