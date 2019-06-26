import 'package:dio/dio.dart';
import 'package:rann_github/util/logger.dart';

class LogInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    Logger.logDebug('request url: ${options.path}');
    if (options.data != null) {
      Logger.logDebug('request param: ${options.data.toString()}');
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if (response != null) {
      Logger.logDebug('response: ${response.toString()}');
    }
    return response;
  }

  @override
  onError(DioError err) {
    Logger.logDebug('request error: ${err.toString()}');
    Logger.logDebug('request info: ' + err.response?.toString() ?? '');
    return err;
  }
}