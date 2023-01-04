import 'dart:io';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'create_book_state.dart';

class CreateBookLogic extends GetxController {
  final CreateBookState state = CreateBookState();

  switchTab(int index) {
    state.tabIndex = index;
  }

  selectAsset() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null || result.files.length == 0 || result.files.single.path == null) {
      return;
    }
    logX.d('cover 路径>>>>>${result.files.single.path}');
    if (result.files.single.path!.endsWith('.pdf') || result.files.single.path!.endsWith('.epub') || result.files.single.path!.endsWith('.txt')) {
      state.asset.value = File(result.files.single.path!);
    }
    checkButtonValid();
  }

  selectCover() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.length > 0 && result.files.single.path != null) {
      logX.d('cover 路径>>>>>${result.files.single.path}');
      state.cover.value = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
    checkButtonValid();
  }

  checkButtonValid() {
    if (state.asset.value == null || state.cover.value == null || state.titleController.text.isEmpty || state.descController.text.isEmpty) {
      state.buttonValid.value = false;
    } else {
      state.buttonValid.value = true;
    }
  }

  uploadBook() async {
    state.setBusy();
    await NetWork.getInstance()
        .assets
        .upload(file: state.asset.value!, cover: state.cover.value!, title: state.titleController.text, desc: state.descController.text)
        .onError((error, stackTrace) => state.setError());
    state.setIdle();
  }

  @override
  void onInit() {
    state.titleController.addListener(() => checkButtonValid());
    state.descController.addListener(() => checkButtonValid());
    super.onInit();
  }

  @override
  void onClose() {
    state.titleController.removeListener(() {});
    state.descController.removeListener(() {});
    super.onClose();
  }
}
