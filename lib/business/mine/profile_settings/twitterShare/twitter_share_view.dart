import 'package:dbook/business/service_api/base/api_constants.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appBar.dart';

class TwitterShareView extends StatelessWidget {
  final twitterApiUrl = 'https://twitter.com/intent/tweet';

  late InAppWebViewController? inAppWebViewController;
  final String authorName;
  final String? authorId;
  final String? bookName;
  final String? bookId;

  TwitterShareView({required this.authorName,this.authorId, this.bookName, this.bookId}){
    assert(bookId != null || authorId != null);
    getUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: 'Share', goBack: _goBack),
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
          initialUrlRequest: URLRequest(url: getUrl()),
        ));
  }

  Uri getUrl() {
    // 内嵌的网页链接

    // 替换path
    var path;
    if (bookId != null) {
      path = 'issueInfo/$bookId/display';
    } else {
      path = 'authorCenter/$authorId';
    }
    var contentUrl = Uri.parse(ApiConstants.BASE_URL.replaceAll('api/v1/', path));

    // 文案描述
    var b = (bookName != null && bookName!.isNotEmpty) ? ' 《$bookName》' : '';
    var content = "I'm looking at the rare edition$b book released by $authorName, so come and check it out on #dbookmarket. #BookLovers #author";

    Uri shareUri = Uri(scheme: 'https',host: 'twitter.com',path: 'intent/tweet',queryParameters: {'text': '$content\n\n$contentUrl'});
    logX.d('分享链接>>>>$shareUri');
    return shareUri;
  }

  /// 判断网页是否可以返回
  _goBack() {
    inAppWebViewController?.canGoBack().then((value) => {value ? inAppWebViewController?.goBack() : Get.back()});
  }
}
