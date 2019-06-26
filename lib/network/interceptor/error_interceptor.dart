import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:rann_github/network/code.dart';
import 'package:rann_github/network/result_data.dart';
import 'package:rann_github/common/events.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptor(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connRes = await Connectivity().checkConnectivity();
    if (connRes == ConnectivityResult.none) {
      return _dio.resolve(
        ResultData(
          errorHandleFunction(Code.NETWORK_ERROR, '', false),
          false,
          Code.NETWORK_ERROR
        )
      );
    }
  }

  static resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }
    return ResultData(
      errorHandleFunction(errorResponse.statusCode, e.message, false),
      false,
      errorResponse.statusCode
    );
  }

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }

    eventBus.fire(HttpErrorEvent(code, message));
    return message;
  }
}