import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/utils.dart';
import 'package:rann_github/widget/card_item.dart';
import 'package:redux/redux.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:rann_github/bloc/trend_bloc.dart';
import 'package:rann_github/util/navigator_utils.dart';
import 'package:rann_github/widget/nested_refresh.dart';
import 'package:rann_github/widget/repo_item.dart';

class TrendPage extends StatefulWidget {
  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage>
    with AutomaticKeepAliveClientMixin<TrendPage>, SingleTickerProviderStateMixin
{
  TrendTypeModel selectTime;
  TrendTypeModel selectType;

  final GlobalKey<NestedScrollViewRefreshIndicatorState> refreshIndicatorKey
    = GlobalKey<NestedScrollViewRefreshIndicatorState>();

  final ScrollController scrollController = ScrollController();

  final TrendBloc trendBloc = TrendBloc();

  bool get wantKeepAlive => true;

  void _showRefreshLoading() {
    Future.delayed(Duration(seconds: 0), () {
      refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }

  Future<void> requestRefresh() async {
    return trendBloc.requestRefresh(selectTime, selectType);
  }

  @override
  void didChangeDependencies() {
    if (!trendBloc.requested) {
      setState(() {
        selectTime = trendTime(context)[0];
        selectType = trendType(context)[0];
      });
      _showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  _renderItem(e) {
    ReposViewModel reposViewModel = ReposViewModel.fromTrendMap(e);
    return ReposItem(reposViewModel, onPressed: () {
      NavigatorUtils.goReposDetail(context, reposViewModel.ownerName, reposViewModel.repositoryName);
    });
  }

  _renderHeaderPopItem(String data, List<TrendTypeModel> list, PopupMenuItemSelected<TrendTypeModel> onSelected) {
    return Expanded(
      child: PopupMenuButton<TrendTypeModel>(
        child: Center(
          child: Text(data, style: Style.middleTextWhite),
        ),
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return _renderHeaderItemPopItemChild(list);
        },
      ),
    );
  }

  _renderHeaderItemPopItemChild(List<TrendTypeModel> data) {
    List<PopupMenuEntry<TrendTypeModel>> list = List();
    for (TrendTypeModel item in data) {
      list.add(PopupMenuItem<TrendTypeModel>(
        value: item,
        child: Text(item.name),
      ));
    }
    return list;
  }

  _renderHeader(Store<HubState> store, Radius radius) {
    if (selectTime == null && selectType == null) {
      return Container();
    }

    return HubCardItem(
      color: store.state.themeData.primaryColor,
      margin: EdgeInsets.all(0.0),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(radius),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        child: Row(
          children: <Widget>[
            _renderHeaderPopItem(selectTime.name, trendTime(context), (TrendTypeModel result) {
              if (trendBloc.isLoading) {
                Fluttertoast.showToast(msg: Utils.getLocale(context).loadingText);
                return;
              }
              scrollController.animateTo(0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceInOut)
              .then((_) {
                setState(() {
                  selectTime = result;
                });
              });
              _showRefreshLoading();
            }),
            Container(
              height: 10.0, width: 0.5, color: Color(HubColors.whiteThemeColor),
            ),
            _renderHeaderPopItem(selectType.name, trendType(context), (TrendTypeModel result) {
              if (trendBloc.isLoading) {
                Fluttertoast.showToast(msg: Utils.getLocale(context).loadingText);
                return;
              }
              scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut)
              .then((_) {
                setState(() {
                  selectType = result;
                });
                _showRefreshLoading();
              });
            })
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    var statusBar = MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    var bottomArea = MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom;
    var height = MediaQuery.of(context).size.height - statusBar - bottomArea - kBottomNavigationBarHeight - kToolbarHeight;
    return SingleChildScrollView(
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled, Store store) {
    return <Widget>[
      SliverPersistentHeader(
        pinned: true,
      )
    ];
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Text(
      'Trend'
    );
  }
}

class TrendTypeModel {
  final String name;
  final String value;

  TrendTypeModel(this.name, this.value);
}

trendTime(BuildContext context) {
  return [
    new TrendTypeModel(Utils.getLocale(context).trendDay, "daily"),
    new TrendTypeModel(Utils.getLocale(context).trendWeek, "weekly"),
    new TrendTypeModel(Utils.getLocale(context).trendMonth, "monthly"),
  ];
}

///趋势数据语言过滤
trendType(BuildContext context) {
  return [
    TrendTypeModel(Utils.getLocale(context).trendAll, null),
    TrendTypeModel("Java", "Java"),
    TrendTypeModel("Kotlin", "Kotlin"),
    TrendTypeModel("Dart", "Dart"),
    TrendTypeModel("Objective-C", "Objective-C"),
    TrendTypeModel("Swift", "Swift"),
    TrendTypeModel("JavaScript", "JavaScript"),
    TrendTypeModel("PHP", "PHP"),
    TrendTypeModel("Go", "Go"),
    TrendTypeModel("C++", "C++"),
    TrendTypeModel("C", "C"),
    TrendTypeModel("HTML", "HTML"),
    TrendTypeModel("CSS", "CSS"),
    TrendTypeModel("Python", "Python"),
    TrendTypeModel("C#", "c%23"),
  ];
}
