import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dbook/common/config/frame_constant.dart';
import 'package:dbook/common/services/services.dart';
import 'package:dbook/common/utils/utils.dart';


// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

//具体应用配置http类继承此类
abstract class BaseHttp extends DioForNative {
  final CancelToken rootCancelToken = CancelToken();

  BaseHttp() {
    ///json 解析放在了子isolate，不过按文档来看，这个解析速度要慢于直接解析
    ///优点就是不会造成ui卡顿（前提是你的json数据非常大）
    ///需要自身来评估
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(new HeaderInterceptor());

    init();
  }

  void init();

  cancelAllRequest() {
    _cancelToken.cancel(['no available net']);
  }
}

///默认项目所有cancelToken使用这一个，用于断网下取消
///如有特殊需要可以 在ApiInterceptor进行覆盖或者注释
final CancelToken _cancelToken = CancelToken();

///添加拦截器
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.connectTimeout = 1000 * 5;
    options.receiveTimeout = 1000 * 5;

    options.cancelToken = _cancelToken;

    ///这里加入版本信息 在header，可以根据需求更改
    var appVersion = await PlatformUtils.getAppVersion();
    var appNumber = await PlatformUtils.getBuildNum();
    var deviceInfo = StorageService.to.getString(BaseFrameConstant.DEVICE_UUID);
    var appToken = StorageService.to.getString(BaseFrameConstant.APP_TOKEN);

    //var token = CookieManager.getCookies(cookies);

    var version = Map()
      ..addAll({
        'appVersion': appVersion,
        'appNumber': appNumber,
      });
    options.headers['app_token'] = appToken;
    options.headers['version'] = jsonEncode(version);
    options.headers['platform'] = Platform.operatingSystem;
    options.headers['clint_id'] = deviceInfo;
    super.onRequest(options, handler);
  }
}

/// 子类需要重写
abstract class BaseResponseData<T> {
  int? code = 0;
  String? message;
  T? data;
  num? currentTime;

  bool get success;

  BaseResponseData({this.code, this.message, this.data,this.currentTime});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data,currentTime: $currentTime}';
  }
}