/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';

import '../../common/entities/assets_info_entity.dart';
import '../../common/entities/read_info_entity.dart';
import '../../common/entities/user_info_entity.dart';
import '../../common/net/http_x.dart';
import '../../common/utils/logger.dart';
import 'base/api_constants.dart';

class UserApi {
  static UserApi? _singleton;

  factory UserApi() => getSingleton()!;

  static UserApi? getSingleton() {
    if (_singleton == null) {
      _singleton = UserApi._internal();
    }
    return _singleton;
  }

  UserApi._internal() {
    //do stuff
  }
  Future<String> nonce({required String address}) async {
    Map<String, dynamic> params = Map();
    params['address'] = address;
    var response = await httpX.post(ApiConstants.nonce, data: params);
    logX.d('请求结果',response);
    if(response['detail'] != null){
      throw response['detail'];
    }
    return response['nonce'];
  }

  Future<String> login({required String address,required String signature}) async {
    Map<String, dynamic> params = Map();
    params['address'] = address;
    params['signature'] = signature;
    var response = await httpX.post(ApiConstants.login, data: params);
    if(response['detail'] != null){
      throw response['detail'];
    }

    return response['token'];
  }

  Future logout() async {
    Map<String, dynamic> params = Map();
    var response = await httpX.post(ApiConstants.logout, data: params);
    return response;
  }

  Future<UserInfoEntity> userInfo() async {
    Map<String, dynamic> params = Map();
    var response = await httpX.get(ApiConstants.current, queryParameters: params);
    return UserInfoEntity.fromJson(response);
  }

}
