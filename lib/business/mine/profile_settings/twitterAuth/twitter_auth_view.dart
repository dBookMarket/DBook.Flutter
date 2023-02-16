import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appBar.dart';

class TwitterAuthView extends StatelessWidget {
  late InAppWebViewController? inAppWebViewController;

  late String title;
  late String url;
  bool? withToken = false;

  TwitterAuthView(this.title, this.url, {this.withToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: this.title, goBack: _goBack),
        body: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform:
                  InAppWebViewOptions(supportZoom: false, javaScriptEnabled: true, disableHorizontalScroll: true, disableVerticalScroll: false, verticalScrollBarEnabled: false),
              android: AndroidInAppWebViewOptions(useHybridComposition: true),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              )),
          onWebViewCreated: (controller) {
            inAppWebViewController = controller;
          },
          onLoadStart: (_, Uri? url) => authResult(url),
          initialUrlRequest: URLRequest(url: Uri.tryParse(url)),
        ));
  }

  authResult(Uri? uri) {
    if (uri == null) return;
    final param = uri.queryParameters;
    if (param['type'] == 'twitter' && param['isAuth'] == 'true' && param.containsKey('oauth_token') && param.containsKey('oauth_verifier')) {
      Get.back(result: param);
    }
  }

  /// 判断网页是否可以返回
  _goBack() {
    inAppWebViewController?.canGoBack().then((value) => {value ? inAppWebViewController?.goBack() : Get.back()});
  }
}
