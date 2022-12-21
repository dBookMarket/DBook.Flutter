/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';

import 'package:dbook/common/exception/data_parse_exception.dart';

import '../../common/entities/assets_info_entity.dart';
import '../../common/entities/issues_entity.dart';
import '../../common/entities/read_info_entity.dart';
import '../../common/net/http_x.dart';
import '../../common/utils/logger.dart';
import 'base/api_constants.dart';

class AssetsApi {
  static AssetsApi? _singleton;

  factory AssetsApi() => getSingleton()!;

  static AssetsApi? getSingleton() {
    if (_singleton == null) {
      _singleton = AssetsApi._internal();
    }
    return _singleton;
  }

  AssetsApi._internal() {
    //do stuff
  }

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

  Future<List<IssuesEntity>> search({required String search}) async {

    Map<String, dynamic> params = Map();
    params['search'] = search;
    var response = await httpX.get(ApiConstants.issues,queryParameters: params);

    List<IssuesEntity>? issues;
    try {
      logX.e(response['results']);
      issues = (response['results'] as List).map((value) => IssuesEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return issues;
  }

}
