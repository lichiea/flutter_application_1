import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../../di/di.dart';
void setUpDio() {
  dio.options.baseUrl = 'http://api.openweathermap.org/data/2.5/air_pollution/history?'; // общая часть адресов запросов
  dio.options.queryParameters.addAll({
    'lat': 25,
    'lon': 86,
    'start': 1606223802, // 24.11.2020, 16:16:42
    'end': 1606482999, // 27.11.2020, 16:16:39
    'appid': '0b4cdf94c783bd32772c085dfcbb195b', // ключ/токен, выданный при регистрации
  });
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
