part of "card_bloc.dart";

sealed class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardLoad extends CardEvent {
  const CardLoad({this.completer});

  final Completer? completer;

  @override
  List<Object> get props => [];
}
