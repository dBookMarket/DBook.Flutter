/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';

import 'package:dbook/common/entities/trades_list_entity.dart';
import 'package:dbook/common/entities/trend_list_entity.dart';
import 'package:dbook/common/exception/data_parse_exception.dart';

import '../../common/entities/transactions_list_entity.dart';
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

  Future<List<TransactionsListEntity>> transactions({required String issueId}) async {

    Map<String, dynamic> params = Map();
    params['issue'] = issueId;
    var response = await httpX.get(ApiConstants.transactions,queryParameters: params);

    List<TransactionsListEntity>? t;
    try {
      t = (response['results'] as List).map((value) => TransactionsListEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return t;
  }

  Future<List<TrendListEntity>> trendList({required String issueId}) async {

    Map<String, dynamic> params = Map();
    params['issue'] = issueId;
    var response = await httpX.get(ApiConstants.trendList,queryParameters: params);

    List<TrendListEntity>? t;
    try {
      List d = (response['dates'] as List);
      List q = (response['quantities'] as List);

      t = d.asMap().keys.map((index) => TrendListEntity.fromJson({'date':d[index],'quantities':q[index]})).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return t;
  }

}
