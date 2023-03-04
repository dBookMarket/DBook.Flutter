import 'package:dbook/common/key_manager/keystore_manager.dart';
import 'package:dbook/common/store/user.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';

import 'change_password_state.dart';

class ChangePasswordLogic extends GetxController {
  final ChangePasswordState state = ChangePasswordState();

  toggleEye() {
    state.hint.toggle();
  }


  revisePassword() async{
    if(state.oldPasswordController.text.isEmpty){
      state.setError(t: 'Please enter the old password');
      return;
    }

    if(state.passwordController.text.isEmpty){
      state.setError(t: 'Please enter the new password');
      return;
    }

    if(state.passwordAgainController.text.isEmpty){
      state.setError(t: 'Please enter the new password again');
      return;
    }

    if(state.passwordController.text != state.passwordAgainController.text){
      state.setError(t: 'The two passwords are inconsistent');
      return;
    }

    if(UserStore.to.userInfo.address == null){
      state.setError(t: 'Invalid address');
      return;
    }

    state.setBusy();
    bool oldPwd = await Web3KeychainManager.getInstance().verifyPassword(EthereumAddress.fromHex(UserStore.to.userInfo.address!), state.oldPasswordController.text);
    if(!oldPwd){
      state.setError(t: 'The old password is incorrect');
      return;
    }

    bool result = await Web3KeychainManager.getInstance().regenerate(EthereumAddress.fromHex(UserStore.to.userInfo.address!), state.oldPasswordController.text, state.passwordAgainController.text);
    if(result){
      state.setSuccess(t: 'Password modification succeeded');
      Get.back();
    }else{
      state.setError(t: 'Password modification failed');
    }
  }
}
