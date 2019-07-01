import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rann_github/bloc/dynamic_bloc.dart';
import 'package:rann_github/model/Event.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:rann_github/util/event_utils.dart';
import 'package:rann_github/widget/event_item.dart';
import 'package:rann_github/widget/pull_load_widget.dart';
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
    EventViewModel eventViewModel = EventViewModel.fromEventMap(e);
    return EventItem(
      eventViewModel,
      onPressed: () {
        EventUtils.ActionUtils(context, e, '');
      },
    );
  }

  Store<HubState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    super.initState();

    if (dynamicBloc.getDataLength() == 0) {
      dynamicBloc.changeNeedHeaderStatus(false);
      showRefreshLoading();
    }

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    if (dynamicBloc.getDataLength() == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (dynamicBloc.getDataLength() != 0) {
        showRefreshLoading();
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    dynamicBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HubPullLoadWidget(
        dynamicBloc.pullLoadWidgetControl,
        (BuildContext context, int index) => _renderEventItem(dynamicBloc.dataList[index]),
        requestRefresh,
        requestLoadMore,
        refreshKey: refreshIndicatorKey,
        scrollController: scrollController,
        useIos: true,
    );
  }
}