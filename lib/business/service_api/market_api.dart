/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';

import 'package:dbook/common/entities/trades_list_entity.dart';
import 'package:dbook/common/entities/trend_list_entity.dart';
import 'package:dbook/common/exception/data_parse_exception.dart';

import '../../common/entities/collection_entity.dart';
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

  Future<List<TradesListEntity>> trades({required String issueId, int? page}) async {
    Map<String, dynamic> params = Map();
    params['issue'] = issueId;
    params['page'] = page;
    var response = await httpX.get(ApiConstants.trades, queryParameters: params);

    List<TradesListEntity>? trades;
    try {
      trades = (response['results'] as List).map((value) => TradesListEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return trades;
  }

  Future<List<TransactionsListEntity>> transactionsUser({required String? userId, int? page}) async {
    Map<String, dynamic> params = Map();
    if (userId != null) {
      params['user'] = userId;
    }
    params['page'] = page;

    var response = await httpX.get(ApiConstants.transactions, queryParameters: params);
    List<TransactionsListEntity>? t;
    try {
      t = (response['results'] as List).map((value) => TransactionsListEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return t;
  }

  Future<List<TransactionsListEntity>> transactionsCurrent({int? page}) async {
    Map<String, dynamic> params = Map();
    params['page'] = page;
    var response = await httpX.get(ApiConstants.transactionsCurrent, queryParameters: params);

    List<TransactionsListEntity>? t;
    try {
      t = (response['results'] as List).map((value) => TransactionsListEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return t;
  }

  Future<List<TransactionsListEntity>> transactionsIssue({String? issueId, int? page}) async {
    Map<String, dynamic> params = Map();
    if (issueId != null) {
      params['issue'] = issueId;
    }
    params['page'] = page;

    var response = await httpX.get(ApiConstants.transactions, queryParameters: params);

    List<TransactionsListEntity>? t;
    try {
      t = (response['results'] as List).map((value) => TransactionsListEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return t;
  }

  Future<List<CollectionEntity>> pendingOrders({int? page}) async {
    Map<String, dynamic> params = Map();
    params['page'] = page;

    var response = await httpX.get(ApiConstants.tradesCurrent, queryParameters: params);

    List<CollectionEntity>? orders;
    try {
      orders = (response['results'] as List).map((value) => CollectionEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return orders;
  }

  Future<List<TrendListEntity>> trendList({required String issueId, int? page}) async {
    Map<String, dynamic> params = Map();
    params['issue'] = issueId;
    params['page'] = page;
    var response = await httpX.get(ApiConstants.trendList, queryParameters: params);

    List<TrendListEntity>? t;
    try {
      List d = (response['dates'] as List);
      List q = (response['quantities'] as List);

      t = d.asMap().keys.map((index) => TrendListEntity.fromJson({'date': d[index], 'quantities': q[index]})).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return t;
  }

  Future<dynamic> transaction({required int tradeId, required int quantity, String? status, String? hash}) async {
    Map<String, dynamic> params = Map();
    params['trade'] = tradeId;
    params['quantity'] = quantity;
    if (status != null) {
      params['status'] = status;
    }
    if (hash != null) {
      params['hash'] = hash;
    }
    var response = await httpX.post(ApiConstants.transactions, data: params);
    return response;
  }
}
