import 'package:flutter/material.dart';
import 'package:rann_github/i18n/localizations.dart';
import 'package:rann_github/i18n/strings_base.dart';

class Utils {
  static double statusBarHeight = 0.0;
  static void initStatusBarHeight(context) async {

  }

  static HubStringsBase getLocale(BuildContext context) {
    return HubLocalizations.of(context).currentLocalized;
  }

  static bool isEmptyString(String string) {
    return string == null || string.length == 0 || string.trim().length == 0;
  }
}