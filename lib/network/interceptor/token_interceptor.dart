import 'package:dio/dio.dart';
import 'package:rann_github/common/variables.dart';
import 'package:rann_github/util/local_storage.dart';
import 'package:rann_github/util/logger.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers['Authorization'] = _token;
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson['token'] != null) {
        _token = 'token ' + responseJson['token'];
        await LocalStorage.save(Defines.TOKEN_KEY, _token);
      }
    } catch (e) {
      Logger.logDebug(e);
    }
    return response;
  }

  clearAuthorization() {
    _token = null;
    LocalStorage.remove(Defines.TOKEN_KEY);
  }

  getAuthorization() async {
    String token = await LocalStorage.get(Defines.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Defines.USER_BASIC_CODE);
      if (basic != null) {
        return 'Basic $basic';
      }
    }
    this._token = token;
    return token;
  }
}