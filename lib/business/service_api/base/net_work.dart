/*
* Author : horry
* Date : 2021/3/10
*/

import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dbook/common/entities/assets_info_entity.dart';
import 'package:dbook/common/entities/read_info_entity.dart';
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

  Future logout() async {
    Map<String, dynamic> params = Map();
    var response = await httpX.post(ApiConstants.logout, data: params);
    return response;
  }


  // /// 获取我的资产
  // Future<List<AssetsEntity>> assets() async {
  //   var response = await httpX.get(ApiConstants.assets);
  //   List<AssetsEntity>? assets;
  //
  //   try {
  //     assets = (response['results'] as List).map((value) => AssetsEntity.fromJson(value)).toList();
  //   } catch (e) {
  //     logX.e(e);
  //     throw 'parse error';
  //   }
  //   return assets;
  // }

  /// 获取我的资产
  Future<AssetsInfoEntity> assets() async {
    var response = await httpX.get(ApiConstants.assets);
    AssetsInfoEntity assets;
    try {
      assets = assets = AssetsInfoEntity.fromJson(response);
    } catch (e) {
      logX.e(e);
      throw 'parse error';
    }
    return assets;
  }

  Future<ReadInfoEntity> assetsDetail(int id) async {
    var response = await httpX.get('${ApiConstants.assets}/$id/${ApiConstants.read}');
    ReadInfoEntity info;
    try {
      info = ReadInfoEntity.fromJson(response);
    } catch (e) {
      logX.e(e);
      throw 'parse error';
    }
    return info;
  }


  Future mark({required int issue,required int page,required int markId}) async {

    Map<String, dynamic> params = Map();
    params['issue'] = issue;
    params['current_page'] = page;
    var response = await httpX.patch('${ApiConstants.bookmarks}/$markId',data: params);
    return response;
  }

}
