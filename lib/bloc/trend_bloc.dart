
import 'package:rann_github/model/TrendingRepoModel.dart';
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
  }
}