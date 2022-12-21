import 'package:dbook/business/login/verify_password/verify_password_view.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/key_manager/keystore_manager.dart';
import '../../../common/store/user.dart';
import '../../../common/utils/loading.dart';
import '../../../common/utils/logger.dart';
import '../../service_api/base/net_work.dart';
import 'verify_password_state.dart';

class VerifyPasswordLogic extends GetxController {
  final VerifyPasswordState state = VerifyPasswordState();


  onTextChanged(String txt){
    state.password = txt;
  }

  onConfirm(VerifyType type)async{
    if(state.password.isEmpty){
      showError(t: 'password is empty');
      return;
    }

    showLoading();
    var valid = await Web3KeychainManager.getInstance().verifyPassword(Web3KeychainManager.getInstance().addresses()[0], state.password);
    dismissLoading();
    if(!valid){
      showError(t: Web3KeychainManagerError.errorInvaildPassword.message);
      return;
    }
    if(type == VerifyType.verifyPassword){
      Get.back(result: state.password);
      return;
    }
    _getNonce(Web3KeychainManager.getInstance().addresses()[0]);
  }

  _getNonce(EthereumAddress address) async {
    showLoading();
    var nonce = await NetWork.getInstance().user.nonce(address: address.toString()).onError((error, stackTrace) => showError(t: error.toString()));
    await _sign(address, nonce);
    dismissLoading();
  }

  Future _sign(EthereumAddress address, String nonce) async {
    var sign = await Web3KeychainManager.getInstance().signMessage(address, nonce, state.password).onError((error, stackTrace) => showError(t: error.toString()));

    logX.d(bytesToHex(sign));
    await _login(address.toString(), bytesToHex(sign));
  }

  _handleSignError(err){
    // if(err is errorInvaildPassword)
  }

  Future _login(String address, String signature) async {
    String token = await NetWork.getInstance().user.login(address: address, signature: signature).onError((error, stackTrace) => showError(t: error.toString()));
    await UserStore.to.setToken(token);
    // Get.to(()=>AssetsPage());
    Get.back(result: true);
  }
}
