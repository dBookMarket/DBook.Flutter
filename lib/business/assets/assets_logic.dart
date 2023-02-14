
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assets_state.dart';

class AssetsLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final AssetsState state = AssetsState();

  AssetsLogic(){
    getUserInfo();
  }

  getUserInfo()async{
    state.setBusy();
    if(state.assetsType == AssetsType.AUTHOR){
      await getOtherUserInfo();
    }else{
      await getSelfUserInfo();
    }
    state.setIdle();
    await Future.delayed(Duration(milliseconds: 500));
    getFlexibleSpaceH();
  }


  getSelfUserInfo()async{
    state.userInfo.value = UserStore.to.userInfo;
    state.userInfo.value = await UserStore.to.getUserInfo();
    logX.d('更新用户数据>>>>>\n11${state.userInfo.value}');
  }
  getOtherUserInfo()async{
    state.userInfo.value = await NetWork.getInstance().user.otherUserInfo(state.userId!).onError((error, stackTrace) => state.setError());
  }

  getFlexibleSpaceH(){
    final RenderBox box = state.flexibleSpaceKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset(0.0,  20));
    state.flexibleSpaceH.value = offset.dy;
  }

  @override
  void onInit() {
    state.tabController = TabController(vsync: this, length: state.filter.length,initialIndex: state.tabIndex);
    super.onInit();
  }
}
