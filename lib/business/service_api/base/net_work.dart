/*
* Author : horry
* Date : 2021/3/10
*/

class NetWork {
  static NetWork? _singleton;

  factory NetWork() => getInstance();

  static NetWork getInstance() {
    if (_singleton == null) {
      _singleton = NetWork._internal();
    }
    return _singleton!;
  }

  NetWork._internal() {
    // do something
  }
}
