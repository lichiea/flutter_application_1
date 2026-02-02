part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class FavoritesLoad extends FavoritesEvent {}

class FavoritesAdd extends FavoritesEvent {
  final String contentId;
  final String title;
  final String description;

  FavoritesAdd({
    required this.contentId,
    required this.title,
    required this.description,
  });
}

class FavoritesRemove extends FavoritesEvent {
  final String contentId;

  FavoritesRemove(this.contentId);
}

class FavoritesCheckIsFavorite extends FavoritesEvent {
  final String contentId;

  FavoritesCheckIsFavorite(this.contentId);
}