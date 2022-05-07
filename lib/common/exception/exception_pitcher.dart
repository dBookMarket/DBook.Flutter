import 'dart:collection';

import 'package:dbook/common/exception/un_authorized_exception.dart';
import 'package:dbook/common/exception/un_handle_exception.dart';
import 'package:dbook/common/net/base_http.dart';
import 'package:dbook/common/net/bedrock_http.dart';

import 'abnormal_user_exception.dart';
import 'base_exception.dart';



class ExceptionPitcher with _ExceptionNotifyBinding{
  static ExceptionPitcher? _instance;
  factory ExceptionPitcher()=>getSingleton()!;
  ExceptionPitcher._internal(){
    //todo
  }

  static ExceptionPitcher? getSingleton(){
    if(_instance == null){
      _instance = ExceptionPitcher._internal();
    }
    return _instance;
  }



  /// * 根据code 转换Exception
  BaseException transformException(int? code,{String? detail}){
    assert(code!=null,'responseData can not be null!');
    switch(code){
    ///仅为以下测试代码
      case 401://登录过期
        return UnAuthorizedException(message: '登录失效,请重新登录');
      default:
        return UnHandleException(code,detail??"un handle exception");
    }
  }
}

/// mixin [_ExceptionNotifyBinding] can notified a Exception to all the [ExceptionListener] listener.
mixin _ExceptionNotifyBinding{
  final LinkedList<_ExceptionPackage> _packages = LinkedList<_ExceptionPackage>();

  /// 增加一个回调，页面发生时，会通知所有listener
  /// 页面使用后务必移除 [removeListener]
  void addListener(ExceptionListener? listener){
    _packages.add(_ExceptionPackage(listener));

  }

  /// 移除一个回调
  void removeListener(ExceptionListener? listener){
    for(final _ExceptionPackage package in _packages){
      if(package._listener == listener){
        package.unlink();
        return;
      }
    }
  }

}


/// api 异常监听回调
abstract class ExceptionListener<E extends Exception,T extends BaseResponseData>{
  /// what kind of [exception] was happened,with api's [rawData]
  void notifyException({E? exception,T? rawData});
}


/// package  exception with listener
class _ExceptionPackage extends LinkedListEntry<_ExceptionPackage>{

  final ExceptionListener? _listener;

  _ExceptionPackage(this._listener);

}

