import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'concern_author_logic.dart';

class ConcernAuthorPage extends StatelessWidget {
  final logic = Get.put(ConcernAuthorLogic());
  final state = Get.find<ConcernAuthorLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
