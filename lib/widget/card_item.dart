import 'package:flutter/material.dart';
import 'package:rann_github/style/style.dart';

class HubCardItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;

  HubCardItem({
    @required this.child,
    this.margin,
    this.color,
    this.shape,
    this.elevation = 5.0
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??= EdgeInsets.all(10.0);
    shape ??= RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)));
    color ??= Color(HubColors.whiteThemeColor);
    return Card(elevation: elevation, shape: shape, color: color, margin: margin, child: child);
  }
}