import 'package:dio/dio.dart';
import 'package:rann_github/network/interceptor/error_interceptor.dart';
import 'package:rann_github/network/interceptor/response_interceptor.dart';
import 'package:rann_github/network/interceptor/token_interceptor.dart';
import 'package:rann_github/network/result_data.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  static HttpManager _instance = HttpManager._initInstance();
  static HttpManager get instance => _instance;
  factory HttpManager() => _instance;

  Dio _client;
  final TokenInterceptor _tokenInterceptor = TokenInterceptor();

  HttpManager._initInstance() {
    BaseOptions options = BaseOptions();
    options.receiveTimeout = 1000 * 10;
    options.connectTimeout = 1000 * 5;
    _client = Dio(options);

    _client.interceptors.add(_tokenInterceptor);
//    _client.interceptors.add(LogInterceptor());
    _client.interceptors.add(ErrorInterceptor(_client));
    _client.interceptors.add(ResponseInterceptor());
  }

  Future<ResultData> get(String path, Map<String, dynamic> params, Options options) async {
    Response response = await _client.get(path, queryParameters: params, options: options);
    if (response.data is DioError) {
      return ErrorInterceptor.resultError(response.data);
    }
    return response.data;
  }

  Future<ResultData> post(String path, data, Options options) async {
    Response response = await _client.post(path, data: data, options: options);
    if (response.data is DioError) {
      return ErrorInterceptor.resultError(response.data);
    }
    return response.data;
  }

  clearAuthorization() {
    return _tokenInterceptor.clearAuthorization();
  }

  getAuthorization() async {
    return _tokenInterceptor.getAuthorization();
  }
}