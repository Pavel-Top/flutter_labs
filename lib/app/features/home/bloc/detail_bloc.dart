import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_lab/app/features/detail/content_detail.dart';
import 'package:flutter_lab/domain/repositories/content/content_detail_repository_interface.dart';
import 'dart:async';


part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ContentDetailRepositoryInterface contentDetailRepository;

  DetailBloc(this.contentDetailRepository) : super(DetailInitial()) {
    on<DetailLoad>(_detailLoad);
  }

  Future<void> _detailLoad(DetailLoad event, Emitter<DetailState> emit) async {
    try {
      emit(DetailLoadInProgress());

      final contentDetail = await contentDetailRepository.getContentDetail(event.mealId);
      emit(DetailLoadSuccess(contentDetail: contentDetail));
    } catch (exception) {
      emit(DetailLoadFailure(exception: exception));
      
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    
  }
}