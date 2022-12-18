import 'package:get/get.dart';

import 'state.dart';

class MainLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final MainState state = MainState();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  jumpToShop(){
    state.pageController.jumpToPage(1);
  }

  jumpToGroupon(){
    state.pageController.jumpToPage(3);
  }
}
