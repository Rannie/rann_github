import 'package:flutter/material.dart';
import 'package:rann_github/model/user.dart';
import 'package:rann_github/store/locale_reducer.dart';
import 'package:rann_github/store/theme_reducer.dart';
import 'package:rann_github/store/user_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

class HubState {
  User user;
  ThemeData themeData;
  Locale locale;
  Locale platformLocale;

  HubState({this.user, this.themeData, this.locale});
}

HubState appReducer(HubState state, action) {
  return HubState(
    user: userReducer(state.user, action),
    themeData: themeDataReducer(state.themeData, action),
    locale: localeReducer(state.locale, action)
  );
}

final List<Middleware<HubState>> middlewares = [
  EpicMiddleware<HubState>(UserInfoEpic()),
  UserInfoMiddleWare(),
];