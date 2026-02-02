import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app/features/favorites/bloc/favorites_bloc.dart';
import 'package:get_it/get_it.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    super.initState();
    // Получаем FavoritesBloc из GetIt
    _favoritesBloc = GetIt.I<FavoritesBloc>();
    // Загружаем избранное при инициализации
    _favoritesBloc.add(FavoritesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _favoritesBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Избранное')),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesError) {
              return Center(child: Text('Ошибка: ${state.error}'));
            } else if (state is FavoritesLoaded) {
              final favorites = state.favorites;
              if (favorites.isEmpty) {
                return const Center(child: Text('Нет избранных элементов'));
              }
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(item['title'] ?? 'Без названия'),
                    subtitle: Text(item['description'] ?? 'Без описания'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<FavoritesBloc>().add(
                          FavoritesRemove(item['contentId'] ?? ''),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Нажмите кнопку для загрузки'));
          },
        ),
      ),
    );
  }
}