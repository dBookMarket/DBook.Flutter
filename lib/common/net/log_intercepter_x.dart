
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dbook/common/config/frame_constant.dart';
import 'package:dbook/common/services/services.dart';
import 'package:dbook/common/utils/logger.dart';


/// [LogInterceptorX] is used to print logs during network requests.
/// It's better to add [LogInterceptorX] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class LogInterceptorX extends Interceptor {
  LogInterceptorX({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logPrint = print,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for ddid:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String requestStr = '';
    String requestTitle = '';


    requestTitle = '*** Request ***\n'+options.uri.toString();
    // logPrint('*** Request ***');
    // _printKV('uri', options.uri);
    //options.headers;

    if (request) {
      requestStr = requestStr + 'method: '+options.method+'\n';
      // _printKV('method', options.method);
      requestStr = requestStr + 'responseType: '+options.responseType.toString()+'\n';
      // _printKV('responseType', options.responseType.toString());
      // _printKV('followRedirects', options.followRedirects);
      requestStr = requestStr + 'followRedirects: '+options.followRedirects.toString()+'\n';
      // _printKV('connectTimeout', options.connectTimeout);
      requestStr = requestStr + 'connectTimeout: '+options.connectTimeout.toString()+'\n';
      // _printKV('sendTimeout', options.sendTimeout);
      requestStr = requestStr + 'sendTimeout: '+options.sendTimeout.toString()+'\n';
      // _printKV('receiveTimeout', options.receiveTimeout);
      requestStr = requestStr + 'receiveTimeout: '+options.receiveTimeout.toString()+'\n';
      // _printKV(
      //     'receiveDataWhenStatusError', options.receiveDataWhenStatusError);
      requestStr = requestStr + 'receiveDataWhenStatusError: '+options.receiveDataWhenStatusError.toString()+'\n';
      // _printKV('extra', options.extra);
      requestStr = requestStr + 'extra: '+options.extra.toString()+'\n';
    }
    if (requestHeader) {
      requestStr = requestStr + '*** headers start***'+'\n';
      options.headers.forEach((key, v) => requestStr = requestStr + key+': '+v.toString()+'\n');
      requestStr = requestStr + '*** headers end***'+'\n';
    }
    if (requestBody) {
      // _printAll(options.data);
      requestStr = requestStr + 'data: '+options.data.toString()+'\n';
    }

    if(request||requestHeader||requestBody){
      logX.d(requestTitle+'\n'+requestStr,);
    }


    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    _printResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (error) {
      logPrint('*** DioError ***:');
      logPrint('uri: ${err.requestOptions.uri}');
      logPrint('$err');
      if (err.response != null) {
        _printResponse(err.response!);
      }
      logPrint('');
    }
    handler.next(err);
  }

  void _printResponse(Response response) {
    String responseStr = '';
    // _printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      // _printKV('statusCode', response.statusCode);
      responseStr =responseStr+'statusCode: '+response.statusCode.toString()+'\n';
      if (response.isRedirect == true) {
        // _printKV('redirect', response.realUri);
        responseStr =responseStr+'redirect: '+response.realUri.toString()+'\n';
      }

      responseStr =responseStr+'*** headers start***\n';
      var appToken = StorageService.to.getString(BaseFrameConstant.APP_TOKEN);
      responseStr = responseStr + 'token'+': '+(appToken??'null')+'\n';
      response.headers.forEach((key, v) => responseStr =responseStr+key+':  '+v.toString()+'\n');
      responseStr =responseStr+'*** headers end***\n';
    }
    if (responseBody) {
      // _printAll(response.toString());
      responseStr =responseStr+'Response Text:\n'+response.toString()+'\n';
    }
    // logPrint('');
    logX.d('*** Response ***\n'+response.requestOptions.uri.toString()+'\n'+responseStr,);
  }

  void _printKV(String key, Object? v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }
}
