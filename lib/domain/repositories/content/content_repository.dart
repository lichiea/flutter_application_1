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
      
      if (response.data is Map) {
        return Content.fromJson(response.data);
      }
      else {
        throw Exception('Неожиданный формат ответа: ${response.data.runtimeType}');
      }
    } on DioException catch (e) {
      throw e.message ?? 'Ошибка сети: ${e.response?.statusCode}';
    } catch (e, stackTrace) {
      throw 'Ошибка обработки данных: $e';
    }
  }
}