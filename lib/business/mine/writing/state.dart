import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../common/entities/drafts_entity.dart';

class WritingState extends BaseState{
  HtmlEditorController htmlController = HtmlEditorController();
  TextEditingController titleController = TextEditingController();
  DraftsEntity? draft;
  WritingState() {
    draft = Get.arguments?['draftInfo'];
    if(draft!=null){
      logX.d('书籍>>>>>${draft.toString()}');
      titleController.text = draft!.title??'';
    }
  }
}
