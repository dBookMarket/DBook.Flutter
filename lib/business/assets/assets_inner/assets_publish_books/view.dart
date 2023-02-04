import 'package:dbook/business/assets/assets_inner/assets_publish_books/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsPublishBooksPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsPublishBooksLogic get logic => Get.find<AssetsPublishBooksLogic>(tag: tag);
  AssetsPublishBooksState get state => Get.find<AssetsPublishBooksLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsPublishBooksLogic());

    return Container();
  }
}
