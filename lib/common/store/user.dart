import 'dart:convert';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/services/services.dart';
import 'package:dbook/common/values/values.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  // 令牌 token
  String token = '';
  // 用户 profile

  bool get isLogin => _isLogin.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    if(hasToken) _isLogin.value = true;
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
    _isLogin.value = true;
  }

  // 注销
  Future<void> onLogout() async {
    if (_isLogin.value) await NetWork.getInstance().logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    _isLogin.value = false;
    token = '';
  }
}
