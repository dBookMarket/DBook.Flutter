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
    if (err.error is ExceptionInfo) {
      message = err.error.message;
      _businessExceptionAction(err.error);
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
  bool handleServiceException(DioError err) {
    // 网络层异常
    logX.e('未知异常', err);
    if (err.type == DioErrorType.connectTimeout) {
      showError(t: 'Connection timed out, please try again');
      return false;
    } else if (err.type == DioErrorType.receiveTimeout || err.type == DioErrorType.sendTimeout) {
      showError(t: 'Network timed out, please try again');
      return false;
    } else if (err.type == DioErrorType.response) {
      // showError(t: 'The network is abnormal, please check the network!');
      handleBusinessException(err);
      return false;
    } else if (err.type == DioErrorType.other) {
      if (err.error.toString().contains('SocketException')) {
        showError(t: 'Network Unavailable');
        return false;
      }

      // 业务异常处理
      handleBusinessException(err);
      return true;
    } else if (err.type == DioErrorType.cancel) {
      logX.e('request to cancel', err.error);
      return false;
    }
    return true;
  }

  _businessExceptionAction(ExceptionInfo err) {
    switch (err.code) {
      case 401: //登录过期
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
