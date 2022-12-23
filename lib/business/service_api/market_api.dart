/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';

import 'package:dbook/common/entities/trades_list_entity.dart';
import 'package:dbook/common/exception/data_parse_exception.dart';

import '../../common/entities/assets_info_entity.dart';
import '../../common/entities/issues_entity.dart';
import '../../common/entities/read_info_entity.dart';
import '../../common/net/http_x.dart';
import '../../common/utils/logger.dart';
import 'base/api_constants.dart';

class MarketApi {
  static MarketApi? _singleton;

  factory MarketApi() => getSingleton()!;

  static MarketApi? getSingleton() {
    if (_singleton == null) {
      _singleton = MarketApi._internal();
    }
    return _singleton;
  }

  MarketApi._internal() {
    //do stuff
  }

  Future<List<TradesListEntity>> trades({required String issueId}) async {

    Map<String, dynamic> params = Map();
    params['issue'] = issueId;
    var response = await httpX.get(ApiConstants.trades,queryParameters: params);

    List<TradesListEntity>? trades;
    try {
      trades = (response['results'] as List).map((value) => TradesListEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return trades;
  }

}
