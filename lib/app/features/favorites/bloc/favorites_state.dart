part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Map<String, dynamic>> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String error;

  FavoritesError(this.error);
}

class FavoritesIsFavorite extends FavoritesState {
  final bool isFavorite;

  FavoritesIsFavorite(this.isFavorite);
}