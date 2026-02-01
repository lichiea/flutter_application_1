import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/repositories.dart';
import '../../../../di/di.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
part "card_event.dart";
part "card_state.dart";

class CardBloc extends Bloc<CardEvent, CardState> {
  final ContentRepositoryInterface contentRepository;

  CardBloc(this.contentRepository) : super(CardInitial()) {
    on<CardLoad>(_cardLoad);
  }

  Future<void> _cardLoad(event, emit) async {
    try {
      if (state is! CardLoadSuccess) {
        emit(CardLoadInProgress());
      }
      final content = await contentRepository.getContent();
      emit(CardLoadSuccess(content: content));
    } catch (exception, state) {
      emit(CardLoadFailure(exception: exception));
      talker.handle(exception, state);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
