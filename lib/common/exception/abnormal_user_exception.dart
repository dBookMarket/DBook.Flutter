import 'base_exception.dart';

class AbnormalUserException extends BaseException{
  AbnormalUserException(code,message):super.withCode(code,message);

}

