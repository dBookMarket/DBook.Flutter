import 'package:dbook/business/assets/assets_view.dart';
import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/key_manager/keystore_manager.dart';
import '../../../common/utils/loading.dart';
import 'setting_password_state.dart';

class SettingPasswordLogic extends GetxController {
  final SettingPasswordState state = SettingPasswordState();

  toggleEye() {
    logX.d('切换');
    state.hint.toggle();
  }

  Future importMemories() async {
    logX.d('message',state.memories);
    showLoading();
    if (!isPasswordValid()) {
      showError(t: 'Please enter the correct password');
      return;
    }
    await Future.delayed(Duration(milliseconds: 200));
    var address = await Web3KeychainManager.getInstance()
        .importMemories(state.memories, state.passwordController.text)
        .onError((error, stackTrace) => showError(t: error.toString()));
    await getNonce(address);
    dismissLoading();
  }

  bool isPasswordValid() {
    if (state.passwordController.text.isEmpty) return false;
    return state.passwordController.text == state.passwordController.text;
  }

  getNonce(EthereumAddress address) async {
    showLoading();
    var nonce = await NetWork.getInstance().nonce(address: address.toString()).onError((error, stackTrace) => showError(t: error.toString()));
    await sign(address, nonce);
    dismissLoading();
  }

  Future sign(EthereumAddress address, String nonce) async {
    var sign = await Web3KeychainManager.getInstance().signMessage(address, nonce, state.passwordController.text);

    logX.d(bytesToHex(sign));
    await login(address.toString(), bytesToHex(sign));
  }

  Future login(String address, String signature) async {
    String token = await NetWork.getInstance().login(address: address, signature: signature);
    await UserStore.to.setToken(token);
    Web3KeychainManager.getInstance().rescanStorage();
    Get.offAll(()=>AssetsPage());
  }
}
