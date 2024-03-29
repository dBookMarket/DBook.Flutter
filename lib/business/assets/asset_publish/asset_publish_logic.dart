import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/store/trade.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';

import '../assets_state.dart';
import '../assets_view.dart';
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

  bool _checkLegality() {
    int unLegalCount = 0;
    // 版税大于0，小于100的数字
    var royalties = double.tryParse(state.royaltiesController.text) ?? 0;
    if (royalties == 0 || royalties > 100) {
      state.setError(t: 'royalties must be between 0 and 100');
      unLegalCount++;
      state.royaltiesLegal.value = false;
    } else {
      state.royaltiesLegal.value = true;
    }

    // 供应时间是大于零的整数
    var period = int.tryParse(state.periodController.text) ?? 0;
    if (period == 0) {
      state.setError(t: 'Supply cycle must be greater than 0');
      unLegalCount++;
      state.periodLegal.value = false;
    } else {
      state.periodLegal.value = true;
    }

    var limit = int.tryParse(state.limitController.text) ?? 0;
    var count = int.tryParse(state.countController.text) ?? 0;
    //总数量大于零的整数
    if (count == 0) {
      state.setError(t: 'count must be greater than 0');
      unLegalCount++;
      state.countLegal.value = false;
    } else {
      state.countLegal.value = true;
    }

    //每人限制小于总数量
    if (limit > count) {
      state.setError(t: 'limit must be less than count');
      unLegalCount++;
      state.limitLegal.value = false;
    } else {
      state.limitLegal.value = true;
    }
    logX.d('unLegalCount>>>>>>$unLegalCount');
    return unLegalCount == 0;
  }

  setChain(value) {
    state.publicChain.value = value;
    checkButtonValid();
  }

  setCoin(value) {
    state.coinType.value = value;
    checkButtonValid();
  }

  setTime(DateTime value) {
    state.publishTime.value = value;
    checkButtonValid();
  }

  publish() async {
    state.setBusy();
    if (!_checkLegality()) {
      return;
    }

    var result = await TradeStore.to.approveAll(state.publicChain.value);
    if(!result) return;

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
            currency: state.coinType.value,
            isModify: state.issueInfo != null,
            issueId: state.issueInfo?.id)
        .onError((error, stackTrace) => state.setError(t: 'invalid info'));
    state.setSuccess(t: 'success');
    Get.until((route) => route.isFirst);
    Get.to(() => AssetsPage(), arguments: {'title': 'Author', 'assetsType': AssetsType.MY_ASSETS, 'tabIndex': 2}, preventDuplicates: false);
  }

  @override
  void onInit() {
    state.countController.addListener(checkButtonValid);
    state.univalentController.addListener(checkButtonValid);
    state.royaltiesController.addListener(checkButtonValid);
    state.periodController.addListener(checkButtonValid);
    state.limitController.addListener(checkButtonValid);
    super.onInit();
  }

  @override
  void onClose() {
    state.countController.removeListener(() {});
    state.univalentController.removeListener(() {});
    state.royaltiesController.removeListener(() {});
    state.periodController.removeListener(() {});
    state.limitController.removeListener(() {});
    super.onClose();
  }
}
