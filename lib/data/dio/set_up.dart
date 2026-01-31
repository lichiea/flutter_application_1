import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../../di/di.dart';
void setUpDio() {
  dio.options.baseUrl = 'http://api.openweathermap.org/data/2.5/air_pollution/history?'; // общая часть адресов запросов
  dio.options.queryParameters.addAll({
    'lat': 25,
    'lon': 86,
    'start': 1682546400, // 27.4.2023, 1:0:0
    'end': 1682632800, // 28.4.2023, 1:0:0
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
