import 'package:dio/dio.dart';
import 'content.dart';
import '../../../data/data.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;

  @override
  Future<Content> getContent() async {
    try {
      final Response response = await dio.get(Endpoints.content);
      
      print('Response data type: ${response.data.runtimeType}');
      
      if (response.data is Map) {
        return Content.fromJson(response.data);
      }
      else {
        throw Exception('Неожиданный формат ответа: ${response.data.runtimeType}');
      }
    } on DioException catch (e) {
      throw e.message ?? 'Ошибка сети: ${e.response?.statusCode}';
    } catch (e, stackTrace) {
      print('Ошибка в getContent: $e');
      print('Stack trace: $stackTrace');
      throw 'Ошибка обработки данных: $e';
    }
  }
}