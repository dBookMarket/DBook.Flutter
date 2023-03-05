import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';

import '../../../common/entities/issues_entity.dart';

class IssuesDetailState extends BaseState{
  final issuesInfo = IssuesEntity().obs;
  late String issuesId;
  final buyAmount = 1.obs;
  bool alive = true;
  IssuesDetailState() {
    issuesInfo.value = Get.arguments?['detail'] ?? IssuesEntity();
    issuesId = issuesInfo.value.id ?? '0';
  }
}
