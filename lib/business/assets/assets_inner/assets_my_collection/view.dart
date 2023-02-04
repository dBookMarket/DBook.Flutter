import 'package:dbook/business/assets/assets_inner/assets_my_collection/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AssetsMyCollectionPage extends StatelessWidget {
  final tag = DateTime.now().toString();

  AssetsMyCollectionLogic get logic => Get.find<AssetsMyCollectionLogic>(tag: tag);
  AssetsMyCollectionState get state => Get.find<AssetsMyCollectionLogic>(tag: tag).state;

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsMyCollectionLogic());

    return Container();
  }
}
