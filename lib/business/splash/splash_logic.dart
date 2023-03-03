import 'package:dbook/business/main/view.dart';
import 'package:get/get.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  @override
  void onInit() {

    super.onInit();
  }



  _checkLoginState(){
    Get.off(()=>MainPage());
    return;
    // if(UserStore.to.isLogin){
    //   Get.off(()=>MainPage());
    // }else{
    //   if(Web3KeychainManager().addresses().le
    //   ngth>0){
    //     Get.off(()=>MainPage());
    //   }else{
    //     Get.off(()=>GuidePage());
    //   }
    // }
  }

  @override
  void onReady() {
    _checkLoginState();
    super.onReady();
  }
}
