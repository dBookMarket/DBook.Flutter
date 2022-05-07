import 'package:dbook/common/entities/assets_entity.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsState {
  RefreshController refreshController = RefreshController(initialRefresh: false);

  final list = <AssetsEntity>[].obs;
  AssetsState() {
    ///Initialize variables
  }
}
