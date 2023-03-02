import 'package:dbook/business/mine/profile_settings/twitterAuth/twitter_auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appBar.dart';

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
          onLoadStart: (_, Uri? url) => logic.authResult(url),
          initialUrlRequest: URLRequest(url: Uri.tryParse('')),
        ));
  }
}
