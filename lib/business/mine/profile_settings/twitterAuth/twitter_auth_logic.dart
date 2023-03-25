import 'package:dbook/business/mine/profile_settings/twitterAuth/twitter_auth_state.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/store.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/dialog.dart';


class TwitterAuthLogic extends GetxController {
  final TwitterAuthState state = TwitterAuthState();


  twitterAuth() async {
    state.setBusy(t: 'Please verify Twitter first');
    var result = await NetWork.getInstance().user.twitterAuth().onError((error, stackTrace) => state.setError(t: 'failed'));
    if (result.isNotEmpty) {
      state.setIdle();
      state.inAppWebViewController?.loadUrl(urlRequest: URLRequest(url:Uri.tryParse(result)));
    }else{
      state.setError(t: 'failed');
    }
  }

  Future<bool> sendTwitter({required String? token, required String? verifier}) async {
    if(state.twitterController.text.isEmpty) return false;
    // 取消对话框
    // Get.back();
    state.setBusy();
    var result = await NetWork.getInstance()
        .user
        .sendTwitter(token: token, verifier: verifier, content: state.twitterController.text)
        .onError((error, stackTrace) => state.setError(t: 'send failed'));
    state.setBusy();
    await UserStore.to.getUserInfo();
    state.setSuccess(t: result);
    return true;
  }



  @override
  void onInit() {
    twitterAuth();
    super.onInit();
  }
}
