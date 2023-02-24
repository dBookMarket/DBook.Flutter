import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/web3.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';

import 'asset_publish_state.dart';

class AssetPublishLogic extends GetxController {
  final AssetPublishState state = AssetPublishState();

  checkButtonValid() {
    if (state.publishTime.value == null) {
      state.buttonValid.value = false;
      logX.d('publishTime == null');
      return;
    }
    if (state.countController.text.length == 0) {
      state.buttonValid.value = false;
      logX.d('countController == null');
      return;
    }
    if (state.currencyController.text.length == 0) {
      state.buttonValid.value = false;
      logX.d('currencyController == null');
      return;
    }
    if (state.univalentController.text.length == 0) {
      state.buttonValid.value = false;
      logX.d('univalentController == null');
      return;
    }
    if (state.royaltiesController.text.length == 0) {
      state.buttonValid.value = false;
      logX.d('royaltiesController == null');
      return;
    }
    if (state.periodController.text.length == 0) {
      state.buttonValid.value = false;
      logX.d('periodController == null');
      return;
    }
    if (state.limitController.text.length == 0) {
      state.buttonValid.value = false;
      logX.d('limitController == null');
      return;
    }

    state.buttonValid.value = true;
  }

  setChain(value) {
    state.publicChain.value = value;
    checkButtonValid();
  }

  setTime(DateTime value) {
    state.publishTime.value = value.add(Duration(minutes: 2));
    checkButtonValid();
  }

  publish() async {
    logX.d('是否授权11>>>>>>开始');
    state.setBusy();
    var chainType = Web3Store.to.formatChainType(state.publicChain.value);
    if(chainType == null) {
      state.setError(t: 'invalid chain');
      return ;
    }

    // 每次都需要授权
    bool isApproved = await Web3Store.to.isApprovedForAll(chainType);
    logX.d('是否授权11>>>>>>$isApproved');
    if (!isApproved) {
      await Web3Store.to.setApprovalForAll(chainType);
      await Future.delayed(Duration(seconds: 5));
      bool isApproved = await Web3Store.to.isApprovedForAll(chainType);
      logX.d('是否授权11>>>>>>$isApproved');
      state.setIdle();
    }

    return;

    try {
      await Web3Store.to.setApprovalForAll(chainType);
    } catch (e) {
      state.setError(t: 'setApprovalForAll error');
      return;
    }

    await NetWork.getInstance()
        .assets
        .publish(
            bookId: state.bookInfo?.id ?? 0,
            price: state.univalentController.text,
            quantity: state.countController.text,
            royalty: state.royaltiesController.text,
            buyLimit: state.limitController.text,
            publishedAt: state.publishTime.value?.toUtc().toString(),
            duration: state.periodController.text,
            blockChain: state.publicChain.value,
            currency: state.currencyController.text,
            isModify: state.issueInfo != null,
            issueId: state.issueInfo?.id)
        .onError((error, stackTrace) => state.setError(t: 'invalid info'));
    state.setSuccess(t: 'success');
    Get.back();
  }

  @override
  void onInit() {
    state.countController.addListener(checkButtonValid);
    state.currencyController.addListener(checkButtonValid);
    state.univalentController.addListener(checkButtonValid);
    state.royaltiesController.addListener(checkButtonValid);
    state.periodController.addListener(checkButtonValid);
    state.limitController.addListener(checkButtonValid);
    super.onInit();
  }

  @override
  void onClose() {
    state.countController.removeListener(() {});
    state.currencyController.removeListener(() {});
    state.univalentController.removeListener(() {});
    state.royaltiesController.removeListener(() {});
    state.periodController.removeListener(() {});
    state.limitController.removeListener(() {});
    super.onClose();
  }
}
