import 'package:rann_github/common/variables.dart';

class Logger {
  static logDebug(log) {
    if (Defines.DEBUG) {
      print(log);
    }
  }
}