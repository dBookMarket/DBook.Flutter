import 'base_exception.dart';

class AbnormalUserException extends ExceptionInfo{
  AbnormalUserException(code,message):super.withCode(code,message);

}

