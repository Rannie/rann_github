import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/utils.dart';
import 'package:rann_github/widget/flat_button.dart';

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

  static Future<void> showCommitOptionDialog(
      BuildContext context,
      List<String> commitMaps,
      ValueChanged<int> onTap, {
      width = 250.0,
      height = 400.0,
      List<Color> colorList
  }) {
    return showHubDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(HubColors.whiteThemeColor),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: ListView.builder(
              itemCount: commitMaps.length,
              itemBuilder: (context, index) {
                return HubFlatButton(
                  maxLines: 1,
                  mainAxisAlignment: MainAxisAlignment.start,
                  fontSize: 14.0,
                  color: colorList != null ? colorList[index] : Theme.of(context).primaryColor,
                  text: commitMaps[index],
                  textColor: Color(HubColors.whiteThemeColor),
                  onPressed: () {
                    Navigator.pop(context);
                    onTap(index);
                  },
                );
              },
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

  static void launchWebView(BuildContext context, String title, String url) {
    if (url.startsWith('http')) {

    } else {

    }
  }
}