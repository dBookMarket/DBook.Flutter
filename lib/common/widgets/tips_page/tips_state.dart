import 'package:get/get.dart';

enum TipsType { twitter, login }

class TipsState {
  late TipsType type;
  late String title;
  late String content;
  late String left;
  late String right;

  TipsState() {
    type = Get.arguments['type'] ?? TipsType.login;
    if (type == TipsType.login) {
      title = 'Login prompt';
      content = 'You are not currently logged in, the current access content needs to be visible after login.';
      left = 'Cancel ';
      right = 'Login';
    } else {
      title = 'Twitter verification';
      content = 'Currently, the author needs to apply for permission to access the content. You need to bind to Twitter first to obtain the author\'s identity.';
      left = 'Cancel ';
      right = 'Verify';
    }
  }
}
