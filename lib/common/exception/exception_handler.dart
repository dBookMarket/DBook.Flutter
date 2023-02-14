/*
* Author : LiJiqqi
* Date : 2020/6/16
*/

import 'package:dio/dio.dart';

import '../store/user.dart';
import '../utils/loading.dart';
import '../utils/logger.dart';
import 'base_exception.dart';

class ExceptionHandler {
  static const String noToast = 'noToast';
  static final ExceptionHandler _singleton = ExceptionHandler._();

  factory ExceptionHandler() => getInstance();

  static ExceptionHandler getInstance() {
    return _singleton;
  }

  ExceptionHandler._();

  /// 处理业务异常
  handleBusinessException(DioError err) {
    var message;
    if (err.error is BaseException) {
      message = err.error.message;
      _businessExceptionAction(err.error);
      if(err.error.code == 403) return;
    } else {
      message = err.message;
    }

    if (err.requestOptions.headers.containsKey(noToast)) {
      dismissLoading();
      return;
    }
    showError(t: message);
  }

  /// 处理服务端异常
  handleServiceException(DioError err) {
    // 网络层异常
    if (err.type == DioErrorType.connectTimeout) {
      showError(t: '连接超时,请重试');
      return;
    } else if (err.type == DioErrorType.receiveTimeout || err.type == DioErrorType.sendTimeout) {
      showError(t: '网络超时,请重试');
      return;
    } else if (err.type == DioErrorType.response) {
      showError(t: '网络异常,请检查网络!');
      return;
    } else if (err.type == DioErrorType.other) {
      logX.e('未知异常', err.error);
      if (err.error.toString().contains('SocketException')) {
        showError(t: '网络不可用');
        return;
      }
      // 业务异常处理
      handleBusinessException(err);
    } else if (err.type == DioErrorType.cancel) {
      logX.e('请求取消', err.error);
      return;
    }
  }

  _businessExceptionAction(BaseException err) {
    switch (err.code) {
      case 403: //登录过期
        UserStore.to.onLogout();
        break;

      case 502:
        break;
      case 701: //用户未注册
        break;
      default:
        break;
    }
  }
}
