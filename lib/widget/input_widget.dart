import 'package:flutter/material.dart';

class HubInputWidget extends StatefulWidget {
  HubInputWidget({
    Key key,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.textStyle,
    this.controller,
    this.obscureText = false
  }) : super(key: key);

  final bool obscureText;
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;
  final TextStyle textStyle;
  final TextEditingController controller;

  @override
  State<HubInputWidget> createState() => _HubInputWidgetState();
}

class _HubInputWidgetState extends State<HubInputWidget> {
  _HubInputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData != null ? Icon(widget.iconData) : null,
      ),
    );
  }
}