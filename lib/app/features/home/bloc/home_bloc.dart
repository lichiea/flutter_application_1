import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/content/content_repository_interface.dart';
import '../../../../di/di.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/repositories/content/model/content.dart';
import 'dart:async';
part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ContentRepositoryInterface contentRepository;

  HomeBloc(this.contentRepository) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  Future<void> _homeLoad(event, emit) async {
    try {
      if (state is! HomeLoadSuccess) {
        emit(HomeLoadInProgress());
      }
      final content = await contentRepository.getContent();
      emit(HomeLoadSuccess(content: content));
    } catch (exception, state) {
      emit(HomeLoadFailure(exception: exception));
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
