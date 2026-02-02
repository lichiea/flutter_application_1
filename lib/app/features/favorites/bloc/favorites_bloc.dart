import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/services/favorites/favorites_service.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FirestoreFavoritesService favoritesService; // Конкретный тип

  FavoritesBloc({required this.favoritesService}) : super(FavoritesInitial()) {
    on<FavoritesLoad>(_onFavoritesLoad);
    on<FavoritesAdd>(_onFavoritesAdd);
    on<FavoritesRemove>(_onFavoritesRemove);
    on<FavoritesCheckIsFavorite>(_onFavoritesCheckIsFavorite);
  }

  Future<void> _onFavoritesLoad(
    FavoritesLoad event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final favorites = await favoritesService.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onFavoritesAdd(
    FavoritesAdd event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await favoritesService.addFavorite(
        contentId: event.contentId,
        title: event.title,
        description: event.description,
      );
      add(FavoritesCheckIsFavorite(event.contentId));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onFavoritesRemove(
    FavoritesRemove event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await favoritesService.removeFavorite(event.contentId);
      // После удаления перезагружаем список
      add(FavoritesLoad());
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onFavoritesCheckIsFavorite(
    FavoritesCheckIsFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      final isFavorite = await favoritesService.isFavorite(event.contentId);
      emit(FavoritesIsFavorite(isFavorite));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}