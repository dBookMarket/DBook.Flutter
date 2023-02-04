import 'package:dbook/business/assets/assets_inner/assets_author_collection/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsAuthorCollectionPage extends StatelessWidget {
  final tag = DateTime.now().toString();
  AssetsAuthorCollectionLogic get logic => Get.find<AssetsAuthorCollectionLogic>(tag: tag);
  AssetsAuthorCollectionState get state => Get.find<AssetsAuthorCollectionLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsAuthorCollectionLogic());

    return Container();
  }
}
