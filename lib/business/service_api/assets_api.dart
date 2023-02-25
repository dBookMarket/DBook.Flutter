/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';
import 'dart:io';

import 'package:dbook/common/entities/ads_issue_entity.dart';
import 'package:dbook/common/entities/book_entity.dart';
import 'package:dbook/common/entities/drafts_entity.dart';
import 'package:dbook/common/exception/data_parse_exception.dart';
import 'package:dio/dio.dart';

import '../../common/entities/assets_info_entity.dart';
import '../../common/entities/collection_entity.dart';
import '../../common/entities/concern_opus_entity.dart';
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

  /// 我的收藏
  Future<List<CollectionEntity>> assetsCurrent({int? page}) async {
    Map<String, dynamic> params = Map();
    params['page'] = page;
    var response = await httpX.get(ApiConstants.assetsCurrent, queryParameters: params);

    List<CollectionEntity>? collection;
    try {
      collection = (response['results'] as List).map((value) => CollectionEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return collection;
  }

  Future<List<CollectionEntity>> assetsUser({required String? userId,int? page}) async {
    Map<String, dynamic> params = Map();
    params['user'] = userId;
    params['page'] = page;

    var response = await httpX.get(ApiConstants.assets, queryParameters: params);

    List<CollectionEntity>? collection;
    try {
      collection = (response['results'] as List).map((value) => CollectionEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return collection;
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

  Future mark({required int issue, required int page, required int markId}) async {
    Map<String, dynamic> params = Map();
    params['issue'] = issue;
    params['current_page'] = page;
    var response = await httpX.patch('${ApiConstants.bookmarks}/$markId', data: params);
    return response;
  }

  Future<BookEntity> upload({File? file, required File cover, required String title, required String desc, int? draftId}) async {
    var formData = FormData.fromMap({
      'title': title,
      'desc': desc,
      'draft': draftId,
    });

    if (file != null) {
      formData.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last),
      ));
    }

    formData.files.add(MapEntry(
      'cover',
      MultipartFile.fromFileSync(cover.path, filename: cover.path.split('/').last),
    ));

    var response = await httpX.post(ApiConstants.books,
        data: formData,
        options: Options(headers: {"Content-type": "multipart/form-data", 'connectTimeout': 0, 'receiveTimeout': 0}),
        onSendProgress: (c, t) => logX.d('上传进度>>>>>$c $t   ${c / t}'));
    return BookEntity.fromJson(response);
  }

  Future<BookEntity> edit({required int? id, required File cover, required String title, required String desc, int? draftId, File? file}) async {
    var formData = FormData.fromMap({
      'title': title,
      'desc': desc,
      'draft': draftId,
    });

    if (file != null) {
      formData.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last),
      ));
    }

    formData.files.add(MapEntry(
      'cover',
      MultipartFile.fromFileSync(cover.path, filename: cover.path.split('/').last),
    ));

    var response = await httpX.put('${ApiConstants.books}/$id',
        data: formData,
        options: Options(headers: {"Content-type": "multipart/form-data", 'connectTimeout': 0, 'receiveTimeout': 0}),
        onSendProgress: (c, t) => logX.d('上传进度>>>>>$c $t   ${c / t}'));
    return BookEntity.fromJson(response);
  }

  Future<List<IssuesEntity>> search({required String search,int? page}) async {
    Map<String, dynamic> params = Map();
    params['search'] = search;
    params['page'] = page;
    var response = await httpX.get(ApiConstants.issues, queryParameters: params);

    List<IssuesEntity>? issues;
    try {
      issues = (response['results'] as List).map((value) => IssuesEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return issues;
  }

  Future publish(
      {required int bookId,
      required String price,
      required String quantity,
      required royalty,
      required buyLimit,
      required publishedAt,
      required duration,
      required blockChain,
      required currency,
      required bool isModify,
        String? issueId
      }) async {
    Map<String, dynamic> params = Map();
    params['book'] = bookId;
    params['price'] = price;
    params['quantity'] = quantity;
    params['royalty'] = royalty;
    params['buy_limit'] = buyLimit;
    params['published_at'] = publishedAt;
    params['duration'] = duration;
    params['token'] = Map.from({'block_chain': blockChain, 'currency': currency});
    var response;
    if (isModify) {
      response = await httpX.put('${ApiConstants.issues}/$issueId', data: params);
    } else {
      response = await httpX.post(ApiConstants.issues, data: params);
    }

    return response;
  }

  Future deleteIssue({required String id}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.delete('${ApiConstants.issues}/$id', data: params);
    return response;
  }

  Future saveDraft({required String title, required String content, int? id}) async {
    Map<String, dynamic> params = Map();
    params['title'] = title;
    params['content'] = content;
    var response;
    if (id != null) {
      response = await httpX.put('${ApiConstants.drafts}/$id', data: params);
    } else {
      response = await httpX.post(ApiConstants.drafts, data: params);
    }

    return response;
  }

  Future deleteDraft({required String id}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.delete('${ApiConstants.drafts}/$id', data: params);
    return response;
  }

  Future<List<DraftsEntity>> draftList({int? page}) async {
    Map<String, dynamic> params = Map();
    params['page'] = page;
    var response = await httpX.get(ApiConstants.drafts, queryParameters: params);

    List<DraftsEntity>? drafts;
    try {
      drafts = (response['results'] as List).map((value) => DraftsEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return drafts;
  }

  Future<List<BookEntity>> bookList({int? page}) async {
    Map<String, dynamic> params = Map();
    params['page'] = page;
    var response = await httpX.get(ApiConstants.books, queryParameters: params);

    List<BookEntity>? books;
    try {
      books = (response['results'] as List).map((value) => BookEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return books;
  }

  Future<List<IssuesEntity>> issueCurrent({int? page}) async {
    Map<String, dynamic> params = Map();
    params['page'] = page;
    var response = await httpX.get(ApiConstants.issuesCurrent, queryParameters: params);

    List<IssuesEntity>? issues;
    try {
      issues = (response['results'] as List).map((value) => IssuesEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return issues;
  }

  Future<List<IssuesEntity>> issueUser({required String? authorId,int? page}) async {
    Map<String, dynamic> params = Map();
    params['author'] = authorId;
    params['page'] = page;
    var response = await httpX.get(ApiConstants.issues, queryParameters: params);

    List<IssuesEntity>? issues;
    try {
      issues = (response['results'] as List).map((value) => IssuesEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return issues;
  }

  Future<IssuesEntity> issueDetail({required String issueId}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.get('${ApiConstants.issues}/$issueId', queryParameters: params);

    IssuesEntity info;
    try {
      info = IssuesEntity.fromJson(response);
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return info;
  }

  Future deleteBook({required String id}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.delete('${ApiConstants.books}/$id', data: params);
    return response;
  }

  Future wish({required String issue,required bool isWish}) async {
    logX.d('书籍心愿单操作>>>>$isWish');
    Map<String, dynamic> params = Map();
    params['issue'] = issue;
    var response = await httpX.post(isWish?ApiConstants.wishlists:ApiConstants.removeWishlists, data: params);
    return response;
  }

  Future<List<ConcernOpusEntity>> wishList({int? page}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.get(ApiConstants.wishlistsCurrent, queryParameters: params);

    List<ConcernOpusEntity>? issues;
    try {
      issues = (response['results'] as List).map((value) => ConcernOpusEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return issues;
  }

  Future<List<AdsIssueEntity>> ads({int? page}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.get(ApiConstants.advertisements, queryParameters: params);

    List<AdsIssueEntity>? ads;
    try {
      ads = (response['results'] as List).map((value) => AdsIssueEntity.fromJson(value)).toList();
    } catch (e) {
      logX.e(e);
      throw DataParseException();
    }
    return ads;
  }
}
