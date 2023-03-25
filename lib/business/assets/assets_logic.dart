import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/user.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assets_state.dart';

class AssetsLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final AssetsState state = AssetsState();

  AssetsLogic() {
    getUserInfo();
  }

  getUserInfo() async {
    state.setBusy();
    if (state.assetsType == AssetsType.AUTHOR) {
      await getOtherUserInfo();
    } else {
      await getSelfUserInfo();
    }
    state.setIdle();
    await Future.delayed(Duration(milliseconds: 500));
    getFlexibleSpaceH();
  }

  getSelfUserInfo() async {
    state.userInfo.value = UserStore.to.userInfo;
    state.userInfo.value = await UserStore.to.getUserInfo();
  }

  getOtherUserInfo() async {
    state.userInfo.value = await NetWork.getInstance().user.otherUserInfo(state.userId!).onError((error, stackTrace) => state.setError());
  }

  getFlexibleSpaceH() {
    if(state.flexibleSpaceKey.currentContext?.findRenderObject() == null) return;
    final RenderBox box = state.flexibleSpaceKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset(0.0, 20));
    state.flexibleSpaceH.value = offset.dy;
    logX.d('高度>>>>>>${state.flexibleSpaceH.value}');
  }

  collect() async {
    var collect = state.userInfo.value.isFans??false;
    state.setBusy();
    var result = !collect;
    await NetWork.getInstance().user.fans(author:state.userInfo.value.id.toString(),collect: !collect).onError((error, stackTrace) => {state.setError(t: 'failed'),result = collect});
    state.userInfo.value.isFans = result;
    state.userInfo.refresh();
    state.setIdle();
  }

  readMore() async{
    if(state.desLine.value == 2){
      state.desLine.value = 5;
    }else{
      state.desLine.value = 2;
    }
    await Future.delayed(Duration(milliseconds: 100));
    getFlexibleSpaceH();
  }

  @override
  void onInit() {
    state.tabController = TabController(vsync: this, length: state.filter.length, initialIndex: state.tabIndex);
    super.onInit();
  }
}
