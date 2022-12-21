/*
* Author : horry
* Date : 2021/3/10
*/

import 'package:dbook/business/service_api/assets_api.dart';
import 'package:dbook/business/service_api/user_api.dart';
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

  AssetsApi get assets => AssetsApi();
  UserApi get user => UserApi();
}
