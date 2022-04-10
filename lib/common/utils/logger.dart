import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

final LogUtil logX = LogUtil();
class LogUtil {
  static Logger logger = Logger(
    printer: PrettyPrinter(lineLength: 150),
    filter: DevelopmentFilter(),
  );

  /// Log a message at level [Level.verbose].
  v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.wtf(message, error, stackTrace);
  }

  widget(String value, {bool isError = false}){
    if (isError || Get.isLogEnable) logger.e(value,['GET_X']);
  }
}
