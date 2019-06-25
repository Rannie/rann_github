import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rann_github/page/home.dart';
import 'package:rann_github/service/user_service.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/navigator_utils.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  static final String pName = '/';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Store<HubState> store = StoreProvider.of(context);
    Future.delayed(Duration(seconds: 2, milliseconds: 500), () {
      UserService.initUserInfo(store).then((res) {
        if (res != null && res.status) {
          NavigatorUtils.pushReplacementNamed(context, HomePage.pName);
        } else {
          NavigatorUtils.pushReplacementNamed(context, LoginPage.pName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(HubColors.whiteThemeColor),
      child: Center(
          child: Image(
            image: AssetImage('assets/image/welcome.png'),
          )
      )
    );
  }
}