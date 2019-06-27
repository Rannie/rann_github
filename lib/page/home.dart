import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rann_github/i18n/localizations.dart';
import 'package:rann_github/page/dynamic.dart';
import 'package:rann_github/page/my.dart';
import 'package:rann_github/page/search.dart';
import 'package:rann_github/page/trend.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/navigator_utils.dart';
import 'package:rann_github/util/utils.dart';
import 'package:rann_github/widget/home_drawer.dart';
import 'package:rann_github/widget/tab_widget.dart';
import 'package:rann_github/widget/title_bar.dart';

class HomePage extends StatelessWidget {
  static final String pName = 'home';

  Future<bool> _dialogExitApp(BuildContext context) async {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.HOME',
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 16.0),
          Text(text)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(HubIcons.MAIN_DT, Utils.getLocale(context).homeDynamic),
      _renderTab(HubIcons.MAIN_QS, Utils.getLocale(context).homeTrend),
      _renderTab(HubIcons.MAIN_MY, Utils.getLocale(context).homeMy)
    ];

    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: HubTabBarWidget(
        drawer: HomeDrawer(),
        type: HubTabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: <Widget>[
          DynamicPage(),
          TrendPage(),
          MyPage()
        ],
        backgroundColor: Theme.of(context).primaryColor,
        indicatorColor: Color(HubColors.whiteThemeColor),
        title: HubTitleBar(
          HubLocalizations.of(context).currentLocalized.appName,
          iconData: HubIcons.MAIN_SEARCH,
          needRightLocalIcon: true,
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder:
                    (context) => NavigatorUtils.pageContainer(SearchPage())
                )
            );
          },
        ),
      ),
    );
  }
}