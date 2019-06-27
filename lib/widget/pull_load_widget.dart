import 'package:flutter/material.dart';
import 'package:rann_github/widget/flare_pull_controller.dart';
import 'package:rann_github/widget/refresh_sliver.dart' as IOS;

const double iosRefreshHeight = 140;
const double iosRefreshIndicatorExtent = 100;

class HubPullLoadWidget extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final RefreshCallback onLoadMore;
  final RefreshCallback onRefresh;
  final HubPullLoadWidgetControl control;
  final ScrollController scrollController;
  final bool useIos;
  final Key refreshKey;

  HubPullLoadWidget(
      this.control,
      this.itemBuilder,
      this.onRefresh,
      this.onLoadMore, {
        this.refreshKey,
        this.scrollController,
        this.useIos = false
      }
  );

  @override
  State<HubPullLoadWidget> createState() => _HubPullLoadWidgetState();
}

class _HubPullLoadWidgetState extends State<HubPullLoadWidget>
    with HubFlarePullController {

  final GlobalKey<IOS.CupertinoSliverRefreshControlState> siiverRefreshKey =
      GlobalKey<IOS.CupertinoSliverRefreshControlState>();

  ScrollController _scrollController;
  bool isRefreshin = false;
  bool isLoadingMorning = false;

  @override
  ValueNotifier<bool> isActive = ValueNotifier<bool>(true);

  @override
  // TODO: implement getPlayAuto
  bool get getPlayAuto => false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class HubPullLoadWidgetControl extends ChangeNotifier {

}