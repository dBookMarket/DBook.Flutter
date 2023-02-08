import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:get/get.dart';

import 'state.dart';

class WritingLogic extends GetxController {
  final WritingState state = WritingState();

  save(content) async {
    state.setBusy();
    await NetWork.getInstance()
        .assets
        .saveDraft(title: state.titleController.text, content: content, id: state.draft?.id)
        .onError((error, stackTrace) => state.setError(t: 'upload failed'));
    state.setSuccess(t: 'upload success');
  }

  checkSave() async {
    print(state.titleController.text);
    if (state.titleController.text.length == 0) {
      state.setError(t: 'please enter a title');
      return;
    }

    var content = await state.htmlController.getText();
    if (content.length == 0) {
      state.setError(t: 'please enter a content');
      return;
    }
    save(content);
  }

  bool titleEnable() {
    if (state.titleController.text.length == 0) {
      state.setError(t: 'please enter a title');
      return false;
    }
    return true;
  }
}
