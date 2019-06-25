import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/utils.dart';

class UIUtils {
  static Future<void> showLoadingDialog(BuildContext context) {
    return showHubDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: WillPopScope(
            onWillPop: () => Future.value(false),
            child: Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SpinKitCubeGrid(color: Color(HubColors.whiteThemeColor)),
                    ),
                    Container(
                      height: 10.0,
                    ),
                    Container (
                      child: Text(
                        Utils.getLocale(context).loadingText,
                        style: Style.normalTextWhite,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  static Future<T> showHubDialog<T> ({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return  MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor:  1),
            child: SafeArea(child: builder(context))
        );
      }
    );
  }
}