class ExceptionInfo implements Exception {
  String? message = "未知错误";
  int? code = -1;

  ExceptionInfo(this.message);

  ExceptionInfo.withCode(this.code, this.message);

  @override
  String toString() {
    return "${this.runtimeType} : code = $code  $message";
  }
}
