
import 'package:rann_github/model/TrendingRepoModel.dart';
import 'package:rann_github/service/repo_service.dart';
import 'package:rxdart/rxdart.dart';

class TrendBloc {
  bool _requested = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get requested => _requested;

  var _subject = PublishSubject<List<TrendingRepoModel>>();

  Observable<List<TrendingRepoModel>> get stream => _subject.stream;

  Future<void> requestRefresh(selectTime, selectType) async {
    _isLoading = true;
    var res = await RepoService.getTrend(since: selectTime.value, languageType: selectType.value);
    if (res != null && res.status) {
      _subject.add(res.data);
    }
    await doNext(res);
    _isLoading = false;
    _requested = true;
    return;
  }

  doNext(res) async {
    if (res.next != null) {
      var resNext = await res.next;
      if (resNext != null && resNext.status) {
        _subject.add(resNext.data);
      }
    }
  }
}