/*
* Author : horry
* Date : 2021/3/10
*/

import 'package:dbook/common/utils/logger.dart';

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


}
