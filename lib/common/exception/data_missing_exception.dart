import 'base_exception.dart';

class DataMissingException extends BaseException{
  DataMissingException({String message = "data missing"}) : super(message);
}