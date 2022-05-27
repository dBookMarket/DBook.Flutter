import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web3dart/crypto.dart';

import '../../../common/key_manager/keystore_manager.dart';
import '../../../common/utils/loading.dart';
import '../../../common/utils/logger.dart';
import 'import_memories_state.dart';

class ImportMemoriesLogic extends GetxController {
  final ImportMemoriesState state = ImportMemoriesState();

  onMemoriesInput(String txt) {
    if (kDebugMode) state.memories.value = txt;
    logX.d(txt);
  }

  @override
  void onInit() async {
    super.onInit();
    // logX.d(Web3KeychainManager.getInstance().addresses());
    // var sign = await Web3KeychainManager.getInstance().signMessage(
    //     Web3KeychainManager.getInstance().addresses()[0],
    //     '6bb67c2a6f877b02991f103d0f5e2ef930cfa592df8cf81f9887176f335791f1',
    //     '123456');
    //
    // logX.d(Web3KeychainManager.getInstance().uint8ToHex(sign));
  }
}
