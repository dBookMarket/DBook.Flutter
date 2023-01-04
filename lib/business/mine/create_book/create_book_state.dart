import 'dart:io';

import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateBookState extends BaseState {
  final _tabIndex = 0.obs;
  get tabIndex => _tabIndex.value;
  set tabIndex(value) => _tabIndex.value = value;

  final tabs = ['Create a book', 'Draft books'];

  final asset =  Rx<File?>(null);
  final cover =  Rx<File?>(null);
  final buttonValid = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  CreateBookState() {
    ///Initialize variables
  }
}
