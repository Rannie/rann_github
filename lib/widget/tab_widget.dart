import 'package:flutter/material.dart';
import 'package:rann_github/style/style.dart';

class HubTabBarWidget extends StatefulWidget {
  static const int BOTTOM_TAB = 1;
  static const int TOP_TAB = 2;

  final int type;
  final bool resizeToAvoidBottomPadding;
  final List<Widget> tabItems;
  final List<Widget> tabViews;
  final Color backgroundColor;
  final Color indicatorColor;
  final Widget title;
  final Widget drawer;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget bottomBar;
  final TarWidgetControl tarWidgetControl;
  final ValueChanged<int> onPageChanged;

  HubTabBarWidget({
    Key key,
    this.type,
    this.resizeToAvoidBottomPadding,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomBar,
    this.tarWidgetControl,
    this.onPageChanged
  }) : super(key: key);

  @override
  State<HubTabBarWidget> createState() => _HubTabBarState();
}

class _HubTabBarState extends State<HubTabBarWidget>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabItems.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == HubTabBarWidget.TOP_TAB) {
      return _topTypeWidget(context);
    } else {
      return _bottomTypeWidget(context);
    }
  }

  Widget _topTypeWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      floatingActionButton: SafeArea(
        child: widget.floatingActionButton ?? Container(),
      ),
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      persistentFooterButtons: widget.tarWidgetControl == null ?
        null : widget.tarWidgetControl.footerButton,
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        title: widget.title,
        bottom: TabBar(
          controller: _tabController,
          tabs: widget.tabItems,
          indicatorColor: widget.indicatorColor,
          onTap: (index) {
            widget.onPageChanged?.call(index);
            _pageController.jumpTo(MediaQuery.of(context).size.width * index);
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: widget.tabViews,
        onPageChanged: (index) {
          _tabController.animateTo(index);
          widget.onPageChanged?.call(index);
        },
      ),
      bottomNavigationBar: widget.bottomBar,
    );
  }

  Widget _bottomTypeWidget(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        backgroundColor: widget.backgroundColor,
        title: widget.title,
      ),
      body: PageView(
        controller: _pageController,
        children: widget.tabViews,
        onPageChanged: (index) {
          _tabController.animateTo(index);
          widget.onPageChanged?.call(index);
        },
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          tabs: widget.tabItems,
          indicatorColor: widget.indicatorColor,
          onTap: (index) {
            widget.onPageChanged?.call(index);
            _pageController.jumpTo(MediaQuery.of(context).size.width * index);
          },
        ),
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}