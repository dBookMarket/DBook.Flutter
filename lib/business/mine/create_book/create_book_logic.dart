import 'dart:io';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/entities/book_entity.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'create_book_state.dart';

class CreateBookLogic extends GetxController {
  final CreateBookState state = CreateBookState();

  switchTab(int index) {
    state.tabIndex = index;
    if (index == 1 && state.drafts.length == 0) {
      getDrafts();
    }
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
    logX.d('cover 路径>>>>>${state.asset.value}');
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
    if ((state.tabIndex == 0 && state.asset.value == null) ||
        (state.tabIndex == 1 && state.selectedDraftId.value == null) ||
        state.cover.value == null ||
        state.titleController.text.isEmpty ||
        state.descController.text.isEmpty) {
      state.buttonValid.value = false;
    } else {
      state.buttonValid.value = true;
    }
  }

  Future<BookEntity?> uploadBook() async {
    if (state.cover.value is! File) {
      state.setError(t: 'Please choose a cover again');
      return null;
    }
    BookEntity? book;
    state.setBusy();

    var bookFile;
    var draftId;
    if (state.tabIndex == 0) {
      bookFile = state.asset.value;
    } else {
      draftId = state.selectedDraftId.value;
    }

    if (state.editBook.value != null) {
      await NetWork.getInstance()
          .assets
          .edit(id: state.editBook.value?.id, file: bookFile, cover: state.cover.value!, title: state.titleController.text, desc: state.descController.text, draftId: draftId)
          .then((value) => {state.setIdle(), book = value})
          .onError((error, stackTrace) => state.setError());
    } else {
      await NetWork.getInstance()
          .assets
          .upload(file: bookFile, cover: state.cover.value!, title: state.titleController.text, desc: state.descController.text, draftId: draftId)
          .then((value) => {state.setIdle(), book = value})
          .onError((error, stackTrace) => state.setError());
    }
    return book;
  }

  getDrafts() async {
    state.setBusy();
    state.drafts.value = await NetWork.getInstance().assets.draftList(page: 1).onError((error, stackTrace) => state.setError(t: 'invalid draft'));
    state.setIdle();
  }

  selectDraft(int index) {
    state.selectedDraftId.value = state.drafts[index].id;
    checkButtonValid();
  }

  @override
  void onInit() {
    state.titleController.addListener(() => checkButtonValid());
    state.descController.addListener(() => checkButtonValid());
    if (state.tabIndex == 1) {
      getDrafts();
    }
    super.onInit();
  }

  @override
  void onClose() {
    state.titleController.removeListener(() {});
    state.descController.removeListener(() {});
    super.onClose();
  }
}
