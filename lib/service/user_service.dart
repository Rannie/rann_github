import 'package:rann_github/common/data_result.dart';
import 'package:rann_github/common/variables.dart';
import 'package:rann_github/config/ignoreConfig.dart';
import 'package:rann_github/model/user.dart';
import 'package:rann_github/network/address.dart';
import 'package:rann_github/network/http_manager.dart';
import 'package:rann_github/network/result_data.dart';
import 'package:rann_github/store/user_reducer.dart';
import 'package:rann_github/util/local_storage.dart';
import 'package:rann_github/util/logger.dart';
import 'package:redux/redux.dart';
import 'dart:convert';

class UserService {
  static initUserInfo(Store store) async {
    var token = await LocalStorage.get(Defines.TOKEN_KEY);
    DataResult result = await fetchLocalUser();
    if (result != null && result.status && token) {
      store.dispatch(UpdateUserAction(result.data));
    }
    return DataResult(result.data, (result.status && token));
  }

  static fetchLocalUser() async {
    var userString = await LocalStorage.get(Defines.USER_INFO);
    if (userString != null) {
      var userMap = json.decode(userString);
      User user = User.fromJson(userMap);
      return DataResult(user, true);
    } else {
      return DataResult(null, false);
    }
  }

  static fetchUserInfo(username, {needDB = false}) async {

  }

  static login(username, password, store) async {
    String type = username.trim() + ':' + password.trim();
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    Logger.logDebug('login ' + base64Str);
    await LocalStorage.save(Defines.USER_NAME_KEY, username.trim());
    await LocalStorage.save(Defines.USER_BASIC_CODE, base64Str);

    Map<String, dynamic> requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": 'admin_script',
      "client_id": NetConfig.CLIENT_ID,
      "client_secret": NetConfig.CLIENT_SECRET
    };
    
    HttpManager httpManager = HttpManager.instance;
    httpManager.clearAuthorization();
    
    ResultData res = await httpManager.post(Address.getAuthorization(), json.encode(requestParams), null);
    if (res != null && res.result) {
      await LocalStorage.save(Defines.PW_KEY, password);
      var resultData = await fetchUserInfo(null);
    }
  }
}