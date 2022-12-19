import 'dart:math';
import 'dart:ui';

import 'package:dbook/business/assets/assets_view.dart';
import 'package:dbook/business/login/import_memories/import_memories_view.dart';
import 'package:dbook/business/main/view.dart';
import 'package:dbook/common/key_manager/keystore_manager.dart';
import 'package:dbook/common/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/guide/view.dart';
import 'splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  @override
  void onInit() {

    super.onInit();
  }



  _checkLoginState(){
    if(UserStore.to.isLogin){
      Get.off(()=>MainPage());
    }else{
      if(Web3KeychainManager().addresses().length>0){
        Get.off(()=>MainPage());
      }else{
        Get.off(()=>GuidePage());
      }
    }
  }

  @override
  void onReady() {
    _checkLoginState();
    super.onReady();
  }
}
