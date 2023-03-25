import 'package:dbook/business/mine/profile_settings/twitterAuth/twitter_auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/store/user.dart';
import '../../../../common/values/colors.dart';
import '../../../../common/values/fontSize.dart';
import '../../../../common/widgets/appBar.dart';
import '../../../../common/widgets/dialog.dart';

class TwitterAuthView extends StatelessWidget {
  final logic = Get.put(TwitterAuthLogic());
  final state = Get.find<TwitterAuthLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Twitter Auth'),
        body: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform:
                  InAppWebViewOptions(supportZoom: false, javaScriptEnabled: true, disableHorizontalScroll: true, disableVerticalScroll: false, verticalScrollBarEnabled: false),
              android: AndroidInAppWebViewOptions(useHybridComposition: true),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              )),
          onWebViewCreated: (controller) {
            state.inAppWebViewController = controller;
          },
          onLoadStart: (_, Uri? url) => authResult(url),
          initialUrlRequest: URLRequest(url: Uri.tryParse('')),
        ));
  }

  Widget _textField({required TextEditingController controller, String? hint, int? maxLines}) =>
      TextField(
        maxLines: maxLines ?? 1,
        maxLength: 300,
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: FontSizeX.s11, color: ColorX.txtTitle),
        controller: controller,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF999999), fontSize: FontSizeX.s11),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
          ),
          border: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorX.txtTitle,
              width: 1.r,
            ),
            borderRadius: BorderRadius.zero,
          ),
        ),
      );

  authResult(Uri? uri) async{
    if (uri == null) return;
    final param = uri.queryParameters;
    if (param['type'] == 'twitter' && param['isAuth'] == 'true' && param.containsKey('oauth_token') && param.containsKey('oauth_verifier')) {
      await sendTwitter(param);
      Get.back(result: param);
    }
  }

  sendTwitter(param)async{
    var result = await Get.dialog(DialogX(
      title: 'warning',
      contentWidget: _textField(controller: state.twitterController, hint: '', maxLines: 3),
      left: 'cancel',
      right: 'OK',
    ));

    if(result){
      var sendResult = await logic.sendTwitter(token: param?['oauth_token'], verifier: param?['oauth_verifier']);
      return sendResult;
    }
    return result;

  }
}
