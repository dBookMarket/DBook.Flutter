import 'dart:io';

import 'package:dbook/common/entities/book_entity.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/entities/drafts_entity.dart';

class CreateBookState extends BaseState {
  final _tabIndex = 0.obs;

  get tabIndex => _tabIndex.value;

  set tabIndex(value) => _tabIndex.value = value;

  final tabs = ['Select from the file', 'Select from the draft'];

  final asset = Rx<File?>(null);
  final cover = Rx<dynamic>(null);
  final buttonValid = false.obs;
  final drafts = <DraftsEntity>[].obs;
  final selectedDraftId = Rx<int?>(null);
  final editBook = Rx<BookEntity?>(null);

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  CreateBookState() {
    selectedDraftId.value = Get.arguments?['draftId'];
    if (selectedDraftId.value != null) {
      tabIndex = 1;
    }
    editBook.value = Get.arguments?['bookInfo'];
    if(editBook.value!=null){
      titleController.text = editBook.value?.title??'';
      descController.text = editBook.value?.desc??'';
      cover.value = editBook.value?.coverUrl??'';
    }
  }
}
