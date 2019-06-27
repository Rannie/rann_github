import 'package:flutter/material.dart';

class HubTitleBar extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPressed;
  final bool needRightLocalIcon;
  final Widget rightWidget;

  HubTitleBar(this.title, {
    this.iconData,
    this.onPressed,
    this.needRightLocalIcon = false,
    this.rightWidget
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon) ?
          IconButton(
            icon: Icon(iconData, size: 19.0),
            onPressed: onPressed,
          ) : Container();
    }

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          widget
        ],
      ),
    );
  }
}