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
}