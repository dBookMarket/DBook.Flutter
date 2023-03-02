import 'dart:io';

import 'package:dbook/business/mine/profile_settings/twitterAuth/twitter_auth_view.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/user.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/entities/user_info_entity.dart';
import 'profile_settings_state.dart';

class ProfileSettingsLogic extends GetxController {
  final ProfileSettingsState state = ProfileSettingsState();

  selectAvatar() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    state.avatar.value = File(image.path);
    checkButtonValid();
  }

  selectBanner() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    state.banner.value = File(image.path);
    checkButtonValid();
  }

  checkButtonValid() {
    if (state.avatar.value == null &&
        state.banner.value == null &&
        state.nameController.text.isEmpty &&
        state.descController.text.isEmpty &&
        state.nameController.text.isEmpty &&
        state.siteController.text.isEmpty &&
        state.discordController.text.isEmpty &&
        state.nameController.text.isEmpty) {
      state.buttonValid.value = false;
      return;
    }
    state.buttonValid.value = true;
  }

  Future<Map<String, String>?> twitterAuth() async {
    state.setBusy();
    var result = await NetWork.getInstance().user.twitterAuth().onError((error, stackTrace) => state.setError(t: 'failed'));
    state.setIdle();
    if (result.isNotEmpty) {
      Map<String, String> param = await Get.to(() => TwitterAuthView());
      return param;
    }
    return null;
  }

  sendTwitter({required String? token, required String? verifier}) async {
    if(state.twitterController.text.isEmpty) return;
    // 取消对话框
    Get.back();
    state.setBusy();
    var result = await NetWork.getInstance()
        .user
        .sendTwitter(token: token, verifier: verifier, content: state.twitterController.text)
        .onError((error, stackTrace) => state.setError(t: 'send failed'));
    state.setSuccess(t: result);
    UserStore.to.getUserInfo();
  }

  commit() async {
    state.setBusy();
    UserInfoEntity info = await NetWork.getInstance()
        .user
        .modify(
            avatar: state.avatar.value,
            banner: state.banner.value,
            name: state.nameController.text,
            desc: state.descController.text,
            site: state.siteController.text,
            discord: state.discordController.text)
        .onError((error, stackTrace) => state.setError(t: 'update fail'));
    state.setSuccess(t: 'update success');

    UserStore.to.updateUserInfo(info);
  }

  @override
  void onInit() {
    state.nameController.addListener(() => checkButtonValid());
    state.discordController.addListener(() => checkButtonValid());
    state.descController.addListener(() => checkButtonValid());
    state.siteController.addListener(() => checkButtonValid());
    super.onInit();
  }

  @override
  void onClose() {
    state.nameController.removeListener(() {});
    state.discordController.removeListener(() {});
    state.descController.removeListener(() {});
    state.siteController.removeListener(() {});
    super.onClose();
  }
}
