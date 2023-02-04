import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';

import '../../common/entities/user_info_entity.dart';

enum AssetsType{
  MY_ASSETS,
  MY_BOOKS,
  AUTHOR,
}

class AssetsState extends BaseState{
  String? userId;
  late AssetsType assetsType;
  final userInfo = UserInfoEntity().obs;
  AssetsState() {
    userId = Get.arguments?['userId']??'';
    assetsType = Get.arguments?['assetsType']??AssetsType.MY_BOOKS;
  }
}
