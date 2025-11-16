
part of 'detail_bloc.dart';


sealed class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class DetailLoad extends DetailEvent {
  const DetailLoad({required this.mealId, this.completer});

  final String mealId;
  final Completer? completer;

  @override
  List<Object> get props => [mealId];
}