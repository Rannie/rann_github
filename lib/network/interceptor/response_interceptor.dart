import 'package:dio/dio.dart';
import 'package:rann_github/network/code.dart';
import 'package:rann_github/network/result_data.dart';
import 'package:rann_github/util/logger.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    RequestOptions option = response.request;
    try {
      if (option.contentType != null && option.contentType.primaryType == 'text') {
        return ResultData(response.data, true, Code.SUCCESS);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    } catch (e) {
      Logger.logDebug(e.toString() + option.path);
      return ResultData(response.data, false, response.statusCode, headers: response.headers);
    }
  }
}