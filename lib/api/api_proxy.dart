import 'package:piano_app/api/dtos/config_dto.dart';
import 'package:piano_app/api/url_provider.dart';
import 'package:piano_app/main.dart';
import 'package:piano_app/services/api_service.dart';

class ApiProxy {
  static Future<ConfigDto> getConfig() async {
    final api = getIt.get<ApiService>();
    final response = await api.instance.get(UrlProvider.config);
    return ConfigDto.fromJson(response.data!);
  }

  static Future<List<String>> getModes() async {
    final api = getIt.get<ApiService>();
    final response = await api.instance.get<List<String>>(UrlProvider.modes);
    return response.data!;
  }

  static Future<bool> setConfig(ConfigDto config) async {
    final api = getIt.get<ApiService>();
    await api.instance.put(UrlProvider.config, data: config.toJson());
    return true;
  }
}
