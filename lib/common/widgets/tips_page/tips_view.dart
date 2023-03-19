import 'package:dbook/common/widgets/dialog.dart';
import 'package:dbook/common/widgets/tips_page/tips_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/names.dart';
import 'tips_logic.dart';

class TipsPage extends StatelessWidget {
  final logic = Get.put(TipsLogic());
  final state = Get.find<TipsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DialogX(title: state.title, content: state.content, left: state.left, right: state.right,rightCallback: onRightClick,), backgroundColor: Colors.black.withOpacity(0.5));
  }

  onRightClick() {
    if (state.type == TipsType.login) {
      Get.toNamed(AppRoutes.ImportMemories);
    } else {
      Get.toNamed(AppRoutes.TwitterAuth);
    }
  }
}
