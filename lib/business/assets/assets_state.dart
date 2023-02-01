import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';

import '../../common/entities/user_info_entity.dart';

class AssetsState extends BaseState{
  String? userId;
  bool isSelf = true;
  final userInfo = UserInfoEntity().obs;
  AssetsState() {
    userId = Get.arguments?['userId']??'';
    isSelf = Get.arguments?['isSelf']??true;
  }
}
