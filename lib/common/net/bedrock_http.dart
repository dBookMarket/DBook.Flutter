import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dbook/business/service_api/base/api_constants.dart';
import 'package:dbook/common/exception/exception_pitcher.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/directory.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../services/global_time.dart';
import 'base_http.dart';
import 'log_intercepter_x.dart';

final BedRock apiServer = BedRock();

class BedRock extends BaseHttp {
  get currentTime => _currentTime;
  int _currentTime = -1;

  @override
  void init() {
    options
      ..contentType = Headers.jsonContentType
      ..responseType = ResponseType.json
      ..connectTimeout = 5 * 1000
      ..receiveTimeout = 5 * 1000
      ..baseUrl = ApiConstants.BASE_URL;
    interceptors
      ..add(CookieManager(PersistCookieJar(storage: FileStorage(DirectoryUtil.getAppDocPath()))))
      ..add(ApiInterceptor())
      ..add(LogInterceptorX(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    // ..add(LogInterceptorX(
    //     request: false, requestHeader: false, requestBody: false, responseBody: true, responseHeader: true));
  }
}

class ResponseData<T> extends BaseResponseData {
  bool get success => (code == 200);

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = int.tryParse(json['code']) ?? -1;
    message = json['msg'];
    data = json['data'];
    currentTime = json['currentTime'];
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
  }

  ///这里可以根据不同的业务代码 扔出不同的异常
  ///具体要根据后台进行协商
  /// [ViewStateModel] 的子类会对此处进行捕捉，捕捉后逻辑可以在[ExceptionHandler]中处理
  /// * 此处的异常捕捉功能仅在[loadData]中有效
  /// * 如果需要独立收到Api的业务异常，见此类[ExceptionBinding]
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.toString().contains('http')) {
      return super.onResponse(response, handler);
    }

    DateTime serviceTime = HttpDate.parse(response.headers['date'].toString().replaceAll('[', '').replaceAll(']', ''));
    GlobalTimeService.to.resetTime(serviceTime.millisecondsSinceEpoch);

    if (response.statusCode != 200) {
      throw ExceptionPitcher().transformException(response);
    }

    return super.onResponse(response, handler);
    // response.data = ResponseData.fromJson(response.data);
    // if (response.data.success) {
    //   apiServer._currentTime = response.data.currentTime;
    //   return super.onResponse(response, handler);
    // } else {
    //   ///抛出业务异常
    //   throw ExceptionPitcher().transformException(response.data);
    // }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401){
      UserStore.to.removeToken();
    }
    super.onError(err, handler);
  }

}
