import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lab/app/features/detail/detail_screen.dart';
import 'package:flutter_lab/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_lab/di/di.dart';
import 'package:flutter_lab/domain/repositories/content/model/content.dart';
//import 'package:go_router/go_router.dart';
import '../../widgets/widgets.dart';
//import '../detail/detail_screen.dart';
//import '../../extensions/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = getIt<HomeBloc>();

  void loadHome() => _homeBloc.add(const HomeLoad());

  @override
  void initState() {
    loadHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => _buildHomeInitial(),
            HomeLoadInProgress() => _buildHomeLoadInProgress(),
            HomeLoadSuccess() => _buildHomeLoadSuccess(state),
            HomeLoadFailure() => _buildHomeLoadFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildHomeInitial() => const SizedBox.shrink();

  Widget _buildHomeLoadInProgress() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildHomeLoadSuccess(HomeLoadSuccess state) {
    final content = state.content;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Меню десертов',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: content.length,
            itemBuilder: (_, index) => ContentCard(
              title: content[index].title,
              description: content[index].description,
              imagePath: content[index].image,
              onTap: () => _navigateToDetail(context, content[index]),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeLoadFailure(HomeLoadFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ошибка: ${state.exception}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: loadHome,
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Content content) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => DetailScreen(mealId: content.id),
    ),
  );
}
}