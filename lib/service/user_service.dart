import 'package:rann_github/common/data_result.dart';
import 'package:rann_github/common/variables.dart';
import 'package:rann_github/model/user.dart';
import 'package:rann_github/store/user_reducer.dart';
import 'package:rann_github/util/local_storage.dart';
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

  static fetchUserInfo() async {

  }
}