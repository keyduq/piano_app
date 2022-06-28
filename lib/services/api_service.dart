import 'package:dio/dio.dart';
import 'package:piano_app/api/url_provider.dart';

class ApiService {
  late Dio instance;

  ApiService() {
    final options = BaseOptions(baseUrl: UrlProvider.baseUrl);
    instance = Dio(options);
  }
}
