import 'package:flutter/material.dart';

class NavigatorUtils {
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static Widget pageContainer(widget) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .copyWith(textScaleFactor: 1),
      child: widget);
  }

  static goPerson(BuildContext context, String userName) {

  }

  static Future goReposDetail(
      BuildContext context, String userName, String reposName) {

  }

  static Future goPushDetailPage(BuildContext context, String userName,
      String reposName, String sha, bool needHomeIcon) {

  }

  static Future goIssueDetail(
      BuildContext context, String userName, String reposName, String num,
      {bool needRightLocalIcon = false}) {

  }
}