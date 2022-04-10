import 'base_exception.dart';

/// 用于未登录等权限不够,需要跳转授权页面
class ServerApiException extends BaseException {
  ServerApiException({String message = "竟然...崩溃了..."}) : super(message) ;
}