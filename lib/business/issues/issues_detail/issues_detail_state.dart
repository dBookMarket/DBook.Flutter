import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:get/get.dart';

import '../../../common/entities/issues_entity.dart';

class IssuesDetailState extends BaseState{
  late IssuesEntity issuesInfo;
  IssuesDetailState() {
    issuesInfo = Get.arguments?['detail'] ?? IssuesEntity();
  }
}