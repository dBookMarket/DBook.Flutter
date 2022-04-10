abstract class BaseException implements Exception {
  String message = "";
  int code = -1;

  BaseException(this.message);

  BaseException.withCode(this.code, this.message);

  @override
  String toString() {
    return "${this.runtimeType} : code = $code  $message";
  }
}
