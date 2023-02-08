/*
* Author : LiJiqqi
* Date : 2020/5/28
*/

import 'dart:async';
import 'dart:io';

import 'package:dbook/common/entities/book_entity.dart';
import 'package:dbook/common/entities/drafts_entity.dart';
import 'package:dbook/common/exception/data_parse_exception.dart';
import 'package:dio/dio.dart';

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

  Future mark({required int issue, required int page, required int markId}) async {
    Map<String, dynamic> params = Map();
    params['issue'] = issue;
    params['current_page'] = page;
    var response = await httpX.patch('${ApiConstants.bookmarks}/$markId', data: params);
    return response;
  }

  Future<BookEntity> upload({required File file, required File cover, required String title, required String desc, String? draftId}) async {
    var formData = FormData.fromMap({
      'title': title,
      'desc': desc,
      'draft': draftId,
    });

    formData.files.addAll([
      MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last),
      ),
      MapEntry(
        'cover',
        MultipartFile.fromFileSync(cover.path, filename: cover.path.split('/').last),
      ),
    ]);

    var response = await httpX.post(
      ApiConstants.books,
      data: formData,
      options: Options(headers: {"Content-type": "multipart/form-data", 'connectTimeout': 0, 'receiveTimeout': 0}),
      onSendProgress: (c,t)=>logX.d('上传进度>>>>>$c $t   ${c/t}')
    );
    return BookEntity.fromJson(response);
  }

  Future<List<IssuesEntity>> search({required String search}) async {
    Map<String, dynamic> params = Map();
    params['search'] = search;
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


  Future saveDraft({required String title, required String content,int? id}) async {
    Map<String, dynamic> params = Map();
    params['title'] = title;
    params['content'] = content;
    var response;
    if(id!=null){
      response = await httpX.put('${ApiConstants.drafts}/$id', data: params);
    }else{
      response = await httpX.post(ApiConstants.drafts, data: params);
    }

    return response;
  }

  Future deleteDraft({required String id}) async {
    Map<String, dynamic> params = Map();
    var response = await httpX.delete('${ApiConstants.drafts}/$id', data: params);
    return response;
  }



  Future<List<DraftsEntity>> draftList() async {
    Map<String, dynamic> params = Map();
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


}
