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
    if (result != null && result.status && token != null) {
      store.dispatch(UpdateUserAction(result.data));
    }
    return DataResult(result.data, (result.status && token != null));
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

  static Future<DataResult> fetchUserInfo(username, {needDB = false}) async {
    HttpManager httpManager = HttpManager.instance;
    ResultData res;
    if (username == null) {
      res = await httpManager.get(Address.getMyUserInfo(), null, null);
    } else {
      res = await httpManager.get(Address.getUserInfo(username), null, null);
    }

    if (res != null && res.result) {
      String starred = '---';
      if (res.data['type'] != 'Organization') {
        DataResult countRes = await getUserStaredCountNet(res.data['login']);
        if (countRes.status) {
          starred = countRes.data;
        }
      }

      User user = User.fromJson(res.data);
      user.starred = starred;
      if (username == null) {
        LocalStorage.save(Defines.USER_INFO, json.encode(user.toJson()));
      }
      return DataResult(user, true);
    } else {
      return DataResult(res.data, false);
    }
  }

  static getUserStaredCountNet(username) async {
    String url = Address.userStar(username, null) + '&per_page=1';
    ResultData res = await HttpManager.instance.get(url, null, null);
    if (res != null && res.headers != null) {
      try {
        List<String> link = res.headers['link'];
        if (link != null) {
          int indexStart = link[0].lastIndexOf('page=') + 5;
          int indexEnd = link[0].lastIndexOf('>');
          if (indexStart >= 0 && indexEnd >= 0) {
            String count = link[0].substring(indexStart, indexEnd);
            return DataResult(count, true);
          }
        }
      } catch (e) {
        Logger.logDebug(e);
      }
    }
    return DataResult(null, false);
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
    DataResult resultData;
    if (res != null && res.result) {
      await LocalStorage.save(Defines.PW_KEY, password);
      resultData = await fetchUserInfo(null);
      store.dispatch(UpdateUserAction(resultData.data));
    }
    return DataResult(resultData, res.result);
  }
}