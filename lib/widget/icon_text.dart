import 'package:flutter/material.dart';

class HubIconText extends StatelessWidget {
  final String iconText;
  final IconData iconData;
  final TextStyle textStyle;
  final Color iconColor;
  final double padding;
  final double iconSize;
  final VoidCallback onPressed;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double textWidth;

  HubIconText(
      this.iconData,
      this.iconText,
      this.textStyle,
      this.iconColor,
      this.iconSize, {
        this.padding = 0,
        this.onPressed,
        this.mainAxisAlignment = MainAxisAlignment.start,
        this.mainAxisSize = MainAxisSize.max,
        this.textWidth = -1,
  });

  @override
  Widget build(BuildContext context) {
    Widget showText = (textWidth == -1) ? Container(
      child: Text(
        iconText ?? '',
        style: textStyle.merge(TextStyle(textBaseline: TextBaseline.alphabetic)),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ) : Container(
      width: textWidth,
      child: Text(
        iconText,
        style: textStyle.merge(TextStyle(textBaseline: TextBaseline.alphabetic)),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );

    return Container(
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          Icon(
            iconData,
            size: iconSize,
            color: iconColor,
          ),
          Padding(
            padding: EdgeInsets.all(padding),
          ),
          showText
        ],
      ),
    );
  }
}