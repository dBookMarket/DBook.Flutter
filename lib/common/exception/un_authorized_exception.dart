import 'base_exception.dart';

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException extends ExceptionInfo {
  UnAuthorizedException({String message = ""}) : super(message) ;
}