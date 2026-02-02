import 'package:flutter_application_1/domain/services/auth/auth_service.dart';
import 'package:flutter_application_1/domain/services/favorites/favorites_service.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';

import '../data/data.dart';
import '../app/app.dart';
import '../../../../domain/repositories/repositories.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();
  
  // Регистрируем репозитории
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );
  
  // Регистрируем BLoC для контента
  getIt.registerSingleton(HomeBloc(getIt.get<ContentRepositoryInterface>()));
  getIt.registerSingleton(CardBloc(getIt.get<ContentRepositoryInterface>()));
  
  // Регистрируем сервис аутентификации 
  getIt.registerSingleton(AuthService());
  
  // Регистрируем BLoC для аутентификации
  getIt.registerSingleton(AuthBloc(
    authService: getIt<AuthService>(),
  ));
  
  // Регистрируем сервис избранного
  getIt.registerSingleton(FirestoreFavoritesService());
  
  // Регистрируем BLoC для избранного
  getIt.registerSingleton(FavoritesBloc(
    favoritesService: getIt<FirestoreFavoritesService>(),
  ));
}