
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../appBar.dart';
import 'web_page_logic.dart';

class WebPageView extends StatelessWidget {
  final logic = Get.put(WebPageLogic());

  late String title;
  late String url;
  bool? withToken = false;

  WebPageView(this.title, this.url, {this.withToken});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: Column(
        children: <Widget>[
          appBar(title: this.title,goBack:_goBack),
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
              onWebViewCreated: (c){
                logic.controller = c;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 判断网页是否可以返回
  _goBack() {
    logic.controller?.canGoBack().then((value) => {value ? logic.controller?.goBack() : Get.back()});
  }
}
