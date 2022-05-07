/*
* Author : horry
* Date : 2021/3/10
*/

import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dio/dio.dart';

import '../../../common/net/bedrock_http.dart';
import '../../../common/net/http_x.dart';
import 'api_constants.dart';

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

  Future<String> logout() async {
    Map<String, dynamic> params = Map();
    var response = await httpX.post(ApiConstants.logout, data: params);
    return response;
  }


  /// 获取团购列表
  Future<List<AssetsEntity>> assets() async {
    var response = await httpX.get(ApiConstants.assets);
    List<AssetsEntity>? assets;

    try {
      assets = (response['results'] as List).map((value) => AssetsEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw 'parse error';
    }
    return assets;
  }

}
