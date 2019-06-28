import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/utils.dart';
import 'package:rann_github/widget/custom_bouncing_scroll_physics.dart';
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

  final GlobalKey<IOS.CupertinoSliverRefreshControlState> sliverRefreshKey =
      GlobalKey<IOS.CupertinoSliverRefreshControlState>();

  ScrollController _scrollController;
  bool isRefreshing = false;
  bool isLoadingMore = false;

  @override
  ValueNotifier<bool> isActive = ValueNotifier<bool>(true);

  bool playAuto = false;
  @override
  bool get getPlayAuto => getPlayAuto;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels
          == _scrollController.position.maxScrollExtent) {
        if (widget.control.needLoadMore) {
          handleLoadMore();
        }
      }
    });

    widget.control.addListener(() {
      setState(() {});
      try {
        Future.delayed(Duration(seconds: 2), () {
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          _scrollController.notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    });
  }

  _getListCount() {
    if (widget.control.needHeader) {
      return (widget.control.dataList.length > 0)
          ? widget.control.dataList.length + 2
          : widget.control.dataList.length + 1;
    } else {
      if (widget.control.dataList.lenght == 0) {
        return 1;
      }

      return (widget.control.dataList.length > 0)
          ? widget.control.dataList.length + 1
          : widget.control.dataList.length;
    }
  }

  _getItem(int index) {
    if (!widget.control.needHeader
        && index == widget.control.dataList.length
        && widget.control.dataList.length != 0)
    {
      return _buildProgressIndicator();
    }
    else if (widget.control.needHeader
        && index == _getListCount() -1
        && widget.control.dataList.length != 0)
    {
      return _buildProgressIndicator();
    }
    else if (!widget.control.needHeader
        && widget.control.dataList.length == 0)
    {
      return _buildEmpty();
    }
    else
    {
      return widget.itemBuilder(context, index);
    }
  }

  _lockToAwait() async {
    doDelayed() async {
      await Future.delayed(Duration(seconds: 1)).then((_) async {
        if (widget.control.isLoading) {
          return await doDelayed();
        } else {
          return null;
        }
      });
    }

    await doDelayed();
  }

  Future<Null> handleRefresh() async {
    if (widget.control.isLoading) {
      if (isRefreshing) {
        return null;
      }

      await _lockToAwait();
    }

    widget.control.isLoading = true;
    isRefreshing = true;
    await widget.onRefresh?.call();
    isRefreshing = false;
    widget.control.isLoading = false;
    return null;
  }

  Future<Null> handleLoadMore() async {
    if (widget.control.isLoading) {
      if (isLoadingMore) {
        return null;
      }

      await _lockToAwait();
    }

    isLoadingMore = true;
    widget.control.isLoading = true;
    await widget.onLoadMore?.call();
    isLoadingMore = false;
    widget.control.isLoading = false;
    return null;
  }

  Widget _buildProgressIndicator() {
    Widget bottomWidget = (widget.control.needLoadMore) ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitRotatingCircle(
          color: Theme.of(context).primaryColor,
        ),
        Container(
          width: 5.0,
        ),
        Text(
          Utils.getLocale(context).loadMoreText,
          style: TextStyle(
            color: Color(0xFF121917),
            fontSize: 14.0,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    ) : Container();

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: bottomWidget,
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Image(
              image: AssetImage(HubIcons.DEFAULT_USER_ICON),
              width: 70.0,
              height: 70.0,
            ),
          ),
          Container(
            child: Text(
              Utils.getLocale(context).appEmpty,
              style: Style.normalText,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSimpleRefreshIndicator(
          BuildContext context,
          IOS.RefreshIndicatorMode refreshState,
          double pulledExtent,
          double refreshTriggerPullDistance,
          double refreshIndicatorExtent)
  {
    pulledExtentFlare = pulledExtent * 0.6;
    playAuto = refreshState == IOS.RefreshIndicatorMode.refresh;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: pulledExtent > iosRefreshHeight ? pulledExtent : iosRefreshHeight,
        child: FlareActor(
          'static/file/loading_world_now.flr',
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          controller: this,
          animation: 'Earth Moving',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useIos)
    {
      return NotificationListener(
        onNotification: (ScrollNotification notification) {
          sliverRefreshKey.currentState.notifyScrollNotification(notification);
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: CustomBouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
            refreshHeight: iosRefreshHeight
          ),
          slivers: <Widget>[
            IOS.CupertinoSliverRefreshControl(
              key: sliverRefreshKey,
              refreshIndicatorExtent: iosRefreshIndicatorExtent,
              refreshTriggerPullDistance: iosRefreshHeight,
              onRefresh: handleRefresh,
              builder: _buildSimpleRefreshIndicator,
            ),
            SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _getItem(index);
                    },
                  childCount: _getListCount()
                ),
              ),
            )
          ],
        ),
      );
    }
    else
    {
      return RefreshIndicator(
        key: widget.refreshKey,
        onRefresh: handleRefresh,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _getItem(index);
          },
          itemCount: _getListCount(),
          controller: _scrollController,
        )
      );
    }
  }
}

class HubPullLoadWidgetControl extends ChangeNotifier {
  List _dataList = List();
  get dataList => _dataList;
  set dataList(List val) {
    _dataList.clear();
    if (val != null) {
      _dataList.addAll(val);
      notifyListeners();
    }
  }

  addList(List val) {
    if (val != null) {
      _dataList.addAll(val);
      notifyListeners();
    }
  }

  bool _needLoadMore = true;
  get needLoadMore => _needLoadMore;
  set needLoadMore(val) {
    _needLoadMore = val;
    notifyListeners();
  }

  bool _needHeader = true;
  set needHeader(bool val) {
    _needHeader = val;
    notifyListeners();
  }
  get needHeader => _needHeader;

  bool isLoading = false;
}