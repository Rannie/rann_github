import 'package:flutter/material.dart';
import 'package:rann_github/widget/nested_refresh.dart';

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

  get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
    return Text(
      'Trend'
    );
  }
}

///趋势数据过滤显示item
class TrendTypeModel {
  final String name;
  final String value;

  TrendTypeModel(this.name, this.value);
}