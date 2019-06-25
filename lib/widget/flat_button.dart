import 'package:flutter/material.dart';

class HubFlatButton extends StatelessWidget {
  const HubFlatButton({
    Key key,
    this.text,
    this.color,
    this.textColor,
    this.fontSize = 20.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.maxLines = 1,
    this.padding,
    @required this.onPressed
  }) : super (key: key);

  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: padding,
      textColor: textColor,
      color: color,
      onPressed: () {
        this.onPressed.call();
      },
      child: Flex(
        mainAxisAlignment: mainAxisAlignment,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: Text(text,
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}