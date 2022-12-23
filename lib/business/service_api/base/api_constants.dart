class ApiConstants {
  // ignore: non_constant_identifier_names
  // static final String BASE_URL = 'https://api.jidaoapp.com';//正式
  static final String BASE_URL = 'http://dbookmarket.com:56789/api/v1/';//测试
  // static final String BASE_URL = 'http://test.ddid.info/api/v1/';//测试

  /// 测试接口
  /// 登录
  static final String login = "login";
  /// 登录随机数
  static final String nonce = "nonce";
  /// 登出
  static final String logout = "logout";
  /// 用户资产
  static final String assets = "assets";
  /// 书签
  static final String bookmarks = "bookmarks";
  /// 阅读书籍  [assets]/${id}/[read]
  static final String read = "read";

  static final String issues = "issues";

  static final String trades = "trades";

}
