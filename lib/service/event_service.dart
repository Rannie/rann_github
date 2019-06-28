import 'package:rann_github/common/data_result.dart';
import 'package:rann_github/model/Event.dart';
import 'package:rann_github/network/address.dart';
import 'package:rann_github/network/http_manager.dart';
import 'package:rann_github/network/result_data.dart';
import 'package:rann_github/util/logger.dart';
import 'package:rann_github/util/utils.dart';

class EventService {
  static getEventReceived(String username, {page = 1, bool needDb = false}) async {
    if (Utils.isEmptyString(username)) {
      return null;
    }

    String url = Address.getEventReceived(username) + Address.getPageParams('?', page);
    ResultData res = await HttpManager.instance.get(url, null, null);
    if (res != null && res.result) {
      List<Event> list = List();
      var data = res.data;
      if (data == null || data.length == 0) {
        return null;
      }

      Logger.logDebug(data.toString());
      for (var value in data) {
        list.add(Event.fromJson(value));
      }
      return DataResult(list, true);
    } else {
      return DataResult(null, false);
    }
  }
}