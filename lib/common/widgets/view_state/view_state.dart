import 'package:dbook/common/widgets/view_state/state_listener.dart';
import 'package:dio/dio.dart';

class BaseState with ViewStateManager{
  var cancelToken = CancelToken();

}