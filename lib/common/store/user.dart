
import 'dart:convert';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/key_manager/keystore_manager.dart';
import 'package:dbook/common/services/services.dart';
import 'package:dbook/common/values/values.dart';
import 'package:get/get.dart';

import '../../business/login/import_memories/import_memories_view.dart';
import '../entities/user_info_entity.dart';
import '../routes/names.dart';
import '../routes/pages.dart';

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
    _onLoginSuccess();
  }

  _onLoginSuccess() {
    int count = 0;
    if (AppPages.history.contains(AppRoutes.ImportMemories)) {
      count++;
    }
    if (AppPages.history.contains(AppRoutes.SettingPassword)) {
      count++;
    }
    Get.close(count);
  }


  Future removeToken()async{
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, '');
  }

  // 注销
  Future<void> onLogout() async {
    // if (_isLogin.value) await NetWork.getInstance().user.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    Web3KeychainManager.getInstance().removeAll();
    _isLogin.value = false;
    _userInfo.value = UserInfoEntity();
    token = '';
    Get.offAll(()=>ImportMemoriesPage());
  }

  Future<UserInfoEntity> getUserInfo()async{
    if(!isLogin) return UserInfoEntity();
    var info = await NetWork.getInstance().user.userInfo();
    updateUserInfo(info);
    return _userInfo.value;
  }

  updateUserInfo(UserInfoEntity info){
    _userInfo.value = info;
    StorageService.to.setString(STORAGE_USER_INFO_KEY, jsonEncode(_userInfo.value.toJson()));
  }
}
