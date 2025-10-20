part of "card_bloc.dart";

sealed class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

final class CardInitial extends CardState {}

final class CardLoadInProgress extends CardState {}

final class CardLoadSuccess extends CardState {
  final Content content;

  const CardLoadSuccess({ required this.content});

  @override
  List<Object> get props => [content];
}

final class CardLoadFailure extends CardState {
  const CardLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object> get props => [];
}
