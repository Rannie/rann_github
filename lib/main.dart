import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:rann_github/i18n/localizations.dart';
import 'package:rann_github/model/user.dart';
import 'package:rann_github/page/login.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:redux/redux.dart';
import 'package:rann_github/style/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runZoned(() {
    runApp(RannGithubApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
    Provider.debugCheckInvalidValueType = null;
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class RannGithubApp extends StatelessWidget {
  RannGithubApp({Key key}) : super(key: key);

  final store = Store<HubState>(
    appReducer,
    middleware: middlewares,
    initialState: HubState(
      user: User(),
      themeData: ThemeData(primarySwatch: themeColor),
      locale: Locale('zh', 'CH')
    )
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<HubState>(builder: (context, store) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            HubLocalizationsDelegate.delegate
          ],
          locale: store.state.locale,
          supportedLocales: [store.state.locale],
          theme: store.state.themeData,
        );
      }),
    );
  }
}

class HubRootWidget extends StatefulWidget {
  final Widget child;
  HubRootWidget({Key key, this.child}) : super(key: key);

  @override
  State<HubRootWidget> createState() => _HubRootWidgetState();
}

class _HubRootWidgetState extends State<HubRootWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
