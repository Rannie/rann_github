import 'package:flutter/material.dart';
import 'package:rann_github/i18n/localizations.dart';
import 'package:rann_github/i18n/strings_base.dart';

class Utils {
  static final double millisLimit = 1000.0;
  static final double secondsLimit = 60 * millisLimit;
  static final double minutesLimit = 60 * secondsLimit;
  static final double hoursLimit = 24 * minutesLimit;
  static final double daysLimit = 30 * hoursLimit;

  static double statusBarHeight = 0.0;
  static void initStatusBarHeight(context) async {

  }

  static HubStringsBase getLocale(BuildContext context) {
    return HubLocalizations.of(context).currentLocalized;
  }

  static bool isEmptyString(String string) {
    return string == null || string.length == 0 || string.trim().length == 0;
  }

  static String getNewsTimeStr(DateTime date) {
    int subTime =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTime < millisLimit) {
      return "刚刚";
    } else if (subTime < secondsLimit) {
      return (subTime / millisLimit).round().toString() + " 秒前";
    } else if (subTime < minutesLimit) {
      return (subTime / secondsLimit).round().toString() + " 分钟前";
    } else if (subTime < hoursLimit) {
      return (subTime / minutesLimit).round().toString() + " 小时前";
    } else if (subTime < daysLimit) {
      return (subTime / hoursLimit).round().toString() + " 天前";
    } else {
      return getDateStr(date);
    }
  }

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }
}