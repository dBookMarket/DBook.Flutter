import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class TwitterAuthState extends BaseState{
  late InAppWebViewController? inAppWebViewController;
  TextEditingController twitterController = TextEditingController();
  late String url;
  TwitterAuthState() {
    twitterController.text = '@ddid_io I have applied to be a dbookmarket author, follow me on Twitter for your chance to get NFT books. #web3';
  }
}
