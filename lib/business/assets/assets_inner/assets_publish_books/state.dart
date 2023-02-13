import 'package:get/get.dart';
import '../../../../common/widgets/refresh_list_view/state.dart';

class AssetsPublishBooksState extends RefreshListViewState{
  late String? authorId;
  AssetsPublishBooksState() {
    this.initRefresh = true;
    this.disableShimmer = false;
    this.initData = true;

    authorId = Get.arguments?['userId'] ?? '';
  }
}
