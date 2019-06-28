import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rann_github/bloc/dynamic_bloc.dart';
import 'package:rann_github/model/Event.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:redux/redux.dart';

class DynamicPage extends StatefulWidget {
  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage>
    with AutomaticKeepAliveClientMixin<DynamicPage>, WidgetsBindingObserver {

  final DynamicBloc dynamicBloc = DynamicBloc();
  final ScrollController scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey
    = GlobalKey<RefreshIndicatorState>();

  showRefreshLoading() {
    Future.delayed(Duration(milliseconds: 500), () {
      scrollController.animateTo(-141,
          duration: Duration(milliseconds: 600),
          curve: Curves.linear);
    });
  }

  Future<void> requestRefresh() async {
    return await dynamicBloc.requestRefresh(_getStore().state.user?.login);
  }

  Future<void>requestLoadMore() async {
    return await dynamicBloc.requestLoadMore(_getStore().state.user?.login);
  }

  _renderEventItem(Event e) {
  }

  Store<HubState> _getStore() {
    return StoreProvider.of(context);
  }

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