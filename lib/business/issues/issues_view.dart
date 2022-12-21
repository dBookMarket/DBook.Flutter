import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'issues_logic.dart';

class IssuesPage extends StatelessWidget {
  final logic = Get.put(IssuesLogic());
  final state = Get.find<IssuesLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
