/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';
import 'dart:io';

import 'package:dbook/common/store/user.dart';
import 'package:dio/dio.dart';

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
    logX.d('请求结果', response);
    if (response['detail'] != null) {
      throw response['detail'];
    }
    return response['nonce'];
  }

  Future<String> login({required String address, required String signature}) async {
    Map<String, dynamic> params = Map();
    params['address'] = address;
    params['signature'] = signature;
    var response = await httpX.post(ApiConstants.login, data: params);
    if (response['detail'] != null) {
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

  Future<UserInfoEntity> modify({File? avatar, File? banner, String? name, String? desc, String? site, String? discord}) async {
    var param = Map<String, dynamic>();
    if (name != null && name.isNotEmpty) {
      param['name'] = name;
    }
    if (desc != null && desc.isNotEmpty) {
      param['desc'] = desc;
    }
    if (site != null && site.isNotEmpty) {
      param['website_url'] = site;
    }
    if (discord != null && discord.isNotEmpty) {
      param['discord_url'] = discord;
    }

    var formData = FormData.fromMap(param);
    if (avatar != null) {
      formData.files.addAll([MapEntry('avatar', MultipartFile.fromFileSync(avatar.path, filename: avatar.path.split('/').last))]);
    }
    if (banner != null) {
      formData.files.addAll([MapEntry('banner', MultipartFile.fromFileSync(banner.path, filename: banner.path.split('/').last))]);
    }
    var response = await httpX.put(ApiConstants.users + UserStore.to.userInfo.id.toString(), data: formData);
    return UserInfoEntity.fromJson(response);
  }
}
