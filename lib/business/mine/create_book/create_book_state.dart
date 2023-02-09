import 'dart:io';

import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/entities/drafts_entity.dart';

class CreateBookState extends BaseState {
  final _tabIndex = 0.obs;

  get tabIndex => _tabIndex.value;

  set tabIndex(value) => _tabIndex.value = value;

  final tabs = ['Create a book', 'Draft books'];

  final asset = Rx<File?>(null);
  final cover = Rx<File?>(null);
  final buttonValid = false.obs;
  final drafts = <DraftsEntity>[].obs;
  final selectedDraftId = Rx<int?>(null);

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  CreateBookState() {
    selectedDraftId.value = Get.arguments?['draftId'];
    if (selectedDraftId.value != null) {
      tabIndex = 1;
    }
  }
}
