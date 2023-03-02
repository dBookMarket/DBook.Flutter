import 'package:dbook/business/mine/profile_settings/twitterAuth/twitter_auth_state.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/store.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';


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

  authResult(Uri? uri) async{
    if (uri == null) return;
    final param = uri.queryParameters;
    if (param['type'] == 'twitter' && param['isAuth'] == 'true' && param.containsKey('oauth_token') && param.containsKey('oauth_verifier')) {
      state.setBusy();
      await UserStore.to.getUserInfo();
      state.setIdle();
      Get.back(result: param);
    }
  }

  @override
  void onInit() {
    twitterAuth();
    super.onInit();
  }
}
