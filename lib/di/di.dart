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
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );
  getIt.registerSingleton(HomeBloc(getIt.get<ContentRepositoryInterface>()));

}