import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'asset_detail_state.dart';

class AssetDetailLogic extends GetxController {
  final AssetDetailState state = AssetDetailState();

  getDetail() async {
    showLoading();
    await NetWork.getInstance().assetsDetail(state.id).onError((error, stackTrace) => dismissLoading());
    dismissLoading();
  }

  setMark() async {
    showLoading();
    await NetWork.getInstance().mark(issue: 4, page: 1, markId: 4).onError((error, stackTrace) => showError(t: error.toString()));
    dismissLoading();
  }

  initImage() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    state.images.clear();
    state.images.addAll(state.imageTemp);
    dismissLoading();
  }

  download() async {
    showLoading();
    await Dio().download('https://bafybeiblrkj5fqmguhm6etktjqf6sxl7lrnyhhsideq2gpqrzkdqdcrr3y.ipfs.nftstorage.link/page-1.png.sse', 'books/page-1.png.sse').onError((error, stackTrace) => logX.d(error));
    dismissLoading();
  }

  @override
  void onInit() {
    // initImage();
    // getDetail();
    download();
    // 强制横屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    dismissLoading();
    super.onClose();
  }
}
