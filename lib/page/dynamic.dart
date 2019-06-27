import 'package:flutter/material.dart';
import 'package:rann_github/bloc/dynamic_bloc.dart';

class DynamicPage extends StatefulWidget {
  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage>
    with AutomaticKeepAliveClientMixin<DynamicPage>, WidgetsBindingObserver {

  final DynamicBloc dynamicBloc = DynamicBloc();

  @override
  bool get wantKeepAlive => null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      'Dynamic'
    );
  }
}