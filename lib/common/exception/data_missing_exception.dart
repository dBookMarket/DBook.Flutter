import 'base_exception.dart';

class DataMissingException extends ExceptionInfo{
  DataMissingException({String message = "data missing"}) : super(message);
}