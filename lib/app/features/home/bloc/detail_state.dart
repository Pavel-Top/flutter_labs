part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoadInProgress extends DetailState {}

final class DetailLoadSuccess extends DetailState {
  const DetailLoadSuccess({required this.contentDetail});

  final ContentDetail contentDetail;

  @override
  List<Object> get props => [contentDetail];
}

final class DetailLoadFailure extends DetailState {
  const DetailLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object> get props => [exception ?? ''];
}