
import 'dart:convert';

import 'package:dbook/business/login/guide/view.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/services/services.dart';
import 'package:dbook/common/values/values.dart';
import 'package:get/get.dart';

import '../entities/user_info_entity.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  // 令牌 token
  String token = '';
  // 用户 profile

  final _userInfo = UserInfoEntity().obs;
  UserInfoEntity get userInfo => _userInfo.value;

  bool get isLogin => _isLogin.value;
  String? get address => _userInfo.value.address;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    if(token.isNotEmpty){
      _isLogin.value = true;
      var profileOffline = StorageService.to.getString(STORAGE_USER_INFO_KEY);
      if(profileOffline.isNotEmpty) _userInfo(UserInfoEntity.fromJson(jsonDecode(profileOffline)));
      getUserInfo();
    }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
    _isLogin.value = true;
  }

  Future removeToken()async{
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, '');
  }

  // 注销
  Future<void> onLogout() async {
    // if (_isLogin.value) await NetWork.getInstance().user.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAll(()=>GuidePage());
  }

  Future<UserInfoEntity> getUserInfo()async{
    var info = await NetWork.getInstance().user.userInfo();
    updateUserInfo(info);
    return _userInfo.value;
  }

  updateUserInfo(UserInfoEntity info){
    _userInfo.value = info;
    StorageService.to.setString(STORAGE_USER_INFO_KEY, jsonEncode(_userInfo.value.toJson()));
  }
}
