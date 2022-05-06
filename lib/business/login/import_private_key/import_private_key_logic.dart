import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';

import '../../../common/key_manager/keystore_manager.dart';
import 'import_private_key_state.dart';

class ImportPrivateKeyLogic extends GetxController {
  final ImportPrivateKeyState state = ImportPrivateKeyState();

  @override
  void onInit() async {
    super.onInit();
    var address = await Web3KeychainManager.getInstance().importMemories('upon session bone daughter blue surge reason rigid rally party inform state', '123456').onError((error,
        stackTrace) => logX.e(error));
    // Web3KeychainManager.getInstance().remove(address, pwd)
    // var address = await Web3KeychainManager.getInstance()
    //     .importPrivateKey('0e70e24b6b689d9fde649a23f75eb7d7cdd5b93ead6f29b475785a7c8fd03f43', '123456')
    //     .onError((error, stackTrace) => logX.e(error));


    var me =await Web3KeychainManager().exportMemories(address,'123456');
    logX.d(address,me);
  }

  onMemoriesInput(String txt) {
    state.memories = txt;
    // state.pushButtonEnable.value = txt.length >= 3;
  }
}
