import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_lab/app/features/home/bloc/detail_bloc.dart'; // Исправь путь
import 'package:flutter_lab/domain/repositories/content/content_detail_repository_interface.dart';
import 'package:flutter_lab/di/di.dart';

class DetailScreen extends StatefulWidget {
  final String mealId;

  const DetailScreen({super.key, required this.mealId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final DetailBloc _detailBloc;

  @override
  void initState() {
    super.initState();
    _detailBloc = DetailBloc(getIt.get<ContentDetailRepositoryInterface>());
    _detailBloc.add(DetailLoad(mealId: widget.mealId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали десерта'),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
        color: Colors.white, // Цвет иконки "назад"
  ),
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        bloc: _detailBloc,
        builder: (context, state) {
          return switch (state) {
            DetailInitial() => _buildInitial(),
            DetailLoadInProgress() => _buildLoading(),
            DetailLoadSuccess() => _buildSuccess(state),
            DetailLoadFailure() => _buildError(state),
          };
        },
      ),
    );
  }

  Widget _buildInitial() => const Center(
        child: Text('Загрузка...'),
      );

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildSuccess(DetailLoadSuccess state) {
    final detail = state.contentDetail;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Изображение
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: detail.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 250,
                color: Colors.grey[300],
                child: const Icon(Icons.error, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Заголовок
          Text(
            detail.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          
          // Категория и регион
          Row(
            children: [
              _buildInfoChip('Категория: ${detail.category}'),
              const SizedBox(width: 8),
              _buildInfoChip('Регион: ${detail.area}'),
            ],
          ),
          const SizedBox(height: 16),
          
          // Теги (если есть)
          if (detail.tags != null && detail.tags!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Теги: ${detail.tags}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
              ],
            ),
          
          // Инструкции
          Text(
            'Инструкции:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            detail.instructions,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          
          // Видео (если есть)
          if (detail.video != null && detail.video!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Видео рецепт:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  detail.video!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildError(DetailLoadFailure state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Ошибка загрузки',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            state.exception.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _detailBloc.add(DetailLoad(mealId: widget.mealId)),
            child: const Text('Попробовать снова'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.blue[800],
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _detailBloc.close();
    super.dispose();
  }
}