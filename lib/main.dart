import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:rann_github/i18n/localizations.dart';
import 'package:rann_github/model/user.dart';
import 'package:rann_github/page/login.dart';
import 'package:rann_github/page/welcome.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:redux/redux.dart';
import 'package:rann_github/style/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runZoned(() {
    runApp(HubApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
    Provider.debugCheckInvalidValueType = null;
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class HubApp extends StatefulWidget {
  HubApp({Key key}) : super(key: key);

  @override
  State<HubApp> createState() => _HubAppState();
}

class _HubAppState extends State<HubApp> {
  final store = Store<HubState>(
      appReducer,
      middleware: middlewares,
      initialState: HubState(
          user: null,
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
          routes: {
            LoginPage.pName: (context) => LoginPage(),
            WelcomePage.pName: (context) => WelcomePage()
          },
        );
      }),
    );
  }
}