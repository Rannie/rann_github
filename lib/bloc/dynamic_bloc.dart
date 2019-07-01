import 'package:rann_github/common/data_result.dart';
import 'package:rann_github/common/variables.dart';
import 'package:rann_github/service/event_service.dart';
import 'package:rann_github/widget/pull_load_widget.dart';

class DynamicBloc {
  final HubPullLoadWidgetControl pullLoadWidgetControl = HubPullLoadWidgetControl();
  int _page = 1;

  requestRefresh(String username) async {
    print('==== REQUEST REFRESH ====');
    pageReset();
    DataResult res = await EventService.getEventReceived(username, page: _page, needDb: false);
    changeLoadMoreStatus(getLoadMoreStatus(res));
    refreshData(res);
    await doNext(res);
    return res;
  }

  requestLoadMore(String username) async {
    pageUp();
    DataResult res = await EventService.getEventReceived(username, page: _page);
    changeLoadMoreStatus(getLoadMoreStatus(res));
    loadMoreData(res);
    return res;
  }

  pageReset() {
    _page = 1;
  }

  pageUp() {
    _page++;
  }

  changeLoadMoreStatus(bool needLoadMore) {
    pullLoadWidgetControl.needLoadMore = needLoadMore;
  }

  getLoadMoreStatus(res) {
    return (res != null && res.data != null && res.data.length == Defines.PAGE_SIZE);
  }

  int getDataLength() {
    return pullLoadWidgetControl.dataList.length;
  }

  changeNeedHeaderStatus(bool needHeader) {
    pullLoadWidgetControl.needHeader = needHeader;
  }

  refreshData(res) {
    if (res != null) {
      pullLoadWidgetControl.dataList = res.data;
    }
  }

  loadMoreData(res) {
    if (res != null) {
      pullLoadWidgetControl.addList(res.data);
    }
  }

  doNext(res) async {
    if (res.next != null) {
      var resNext = await res.next;
      if (resNext != null && resNext.result) {
        changeLoadMoreStatus(getLoadMoreStatus(resNext));
        refreshData(resNext);
      }
    }
  }

  clearData() {
    refreshData([]);
  }

  get dataList => pullLoadWidgetControl.dataList;

  void dispose() {
    pullLoadWidgetControl.dispose();
  }
}