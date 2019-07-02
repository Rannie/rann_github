import 'package:rann_github/common/data_result.dart';
import 'package:rann_github/model/TrendingRepoModel.dart';
import 'package:rann_github/network/address.dart';
import 'package:rann_github/util/trend_utils.dart';

class RepoService {
  static getTrend({since = 'daily', languageType, page = 0, needDb = true}) async {
    String url = Address.trending(since, languageType);
    var res = await GitHubTrending().fetchTrending(url);
    if (res != null && res.result && res.data.length > 0) {
      List<TrendingRepoModel> list = List();
      var data = res.data;
      if (data == null || data.length == 0) {
        return DataResult(null, false);
      }

      for (int i = 0; i < data.length; i++) {
        TrendingRepoModel model = data[i];
        list.add(model);
      }
      return DataResult(list, true);
    } else {
      return DataResult(null, false);
    }
  }
}