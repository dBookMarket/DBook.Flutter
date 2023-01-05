import 'dart:io';

import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileSettingsState extends BaseState{
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController discordController = TextEditingController();

  final avatar = Rx<File?>(null);
  final banner = Rx<File?>(null);
  final buttonValid = false.obs;
  ProfileSettingsState() {
    ///Initialize variables
  }
}
