
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';

import 'assets_state.dart';

class AssetsLogic extends GetxController {
  final AssetsState state = AssetsState();

  AssetsLogic(){
    getUserInfo();
  }

  getUserInfo(){
    state.setBusy();
    if(state.isSelf){
      getSelfUserInfo();
    }else{
      getOtherUserInfo();
    }
    state.setIdle();
  }


  getSelfUserInfo()async{
    state.userInfo.value = await UserStore.to.getUserInfo();
    logX.d('更新用户数据>>>>>\n11${state.userInfo.value}');
  }
  getOtherUserInfo()async{
    state.userInfo.value = await NetWork.getInstance().user.otherUserInfo(state.userId!).onError((error, stackTrace) => state.setError());
  }
}
