import 'package:rann_github/model/user.dart';
import 'package:rann_github/service/user_service.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final userReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}

class UserInfoMiddleWare implements MiddlewareClass<HubState> {
  @override
  void call(Store<HubState> store, action, NextDispatcher next) {
    if (action is UpdateUserAction) {
      print('==== USER INFO MIDDLEWARE ====');
    }
    next(action);
  }
}

class UserInfoEpic implements EpicClass<HubState> {
  @override
  Stream call(Stream actions, EpicStore<HubState> store) {
    return Observable(actions)
        .ofType(TypeToken<UpdateUserAction>())
        .debounce(((_) => TimerStream(true, const Duration(milliseconds:  10))))
        .switchMap((action) => (_loadUserInfo()));
  }
  
  Stream _loadUserInfo() async* {
    print('==== LOAD USER INFO ====');
    var res = await UserService.fetchUserInfo(null);
    yield UpdateUserAction(res.data);
  }
}