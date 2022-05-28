import 'dart:io';
import 'dart:typed_data';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/generated/assets.dart';
import 'package:dbook_cryptology_plugin/dbook_cryptology_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../assets/assets_logic.dart';
import 'asset_detail_state.dart';

class AssetDetailLogic extends GetxController {
  final AssetDetailState state = AssetDetailState();

  onPageChanged(index,_){
    logX.d('切换页面$index');
    state.currentIndex.value = index;
    loadingImage();
    createMark();
  }

  getDetail() async {
    showLoading();
    state.readInfo.value = await NetWork.getInstance().assetsDetail(state.bookId).onError((error, stackTrace) => dismissLoading());
    for (var i in state.readInfo.value.files??[]) {
      state.localFile.add(i);
    }
    logX.d(state.localFile);
    await loadingImage();
    dismissLoading();
  }

  loadingImage() async {
    logX.d('开始加载第${state.currentIndex.value}页');
    await Future.wait([
      download(state.currentIndex.value - 1),
      download(state.currentIndex.value),
      download(state.currentIndex.value + 1),
    ]).whenComplete(() => dismissLoading());
  }

  Future download(int index) async {
    if (index < 0 || index + 1 > (state.readInfo.value.files?.length ?? 0)) return;
    var tempImagePath = '${state.imagesPath?.path}/$index.png';
    File tempFile = File(tempImagePath);
    if (tempFile.existsSync()) {
      state.localFile[index] = tempFile;
      return;
    }
    var ssePath = await downloadSSE(index);
    var skPath = await downloadSK(index);
    var file = await DBookCryptologyPlugin.decryptImage(filePath: tempImagePath, encFile: ssePath, skFile: skPath);
    state.localFile[index] = file;
  }

  downloadSSE(int index)async{
    var tempPath = '${state.decryptPath?.path}/$index.sse';
    File tempFile = File(tempPath);
    if (tempFile.existsSync()) return tempPath;

    // test
    // var bytes = await rootBundle.load(Assets.filesResPng);
    // ByteBuffer buffer =  bytes.buffer;
    // tempFile.writeAsBytes(buffer.asUint8List(bytes.offsetInBytes,
    //     bytes.lengthInBytes));
    // return tempPath;
    //
    await Dio()
        .download(state.readInfo.value.files![index], tempPath)
        .onError((error, stackTrace) => logX.d(error));
    return tempPath;
  }

  downloadSK(int index)async{
    var tempPath = '${state.decryptPath?.path}/${state.bookName}.stk';
    File tempFile = File(tempPath);
    if (tempFile.existsSync()) return tempPath;

    // test
    // var bytes = await rootBundle.load(Assets.filesBaseBlock);
    // ByteBuffer buffer =  bytes.buffer;
    // tempFile.writeAsBytes(buffer.asUint8List(bytes.offsetInBytes,
    //     bytes.lengthInBytes));
    // return tempPath;

    await Dio()
        .download(state.readInfo.value.sk??'', tempPath)
        .onError((error, stackTrace) => logX.d(error));
    return tempPath;
  }

  /// 新建书签
  createMark() async {
    var listState = Get.find<AssetsLogic>().state;
    // 更新列表书签
    listState.list.where((p0) => p0.id == state.bookId).first.bookmark?.currentPage = state.currentIndex.value;
    listState.list.refresh();
    await NetWork.getInstance().mark(issue: state.markIssue, page: state.currentIndex.value, markId: state.markId).onError((error, stackTrace) => showError(t: error.toString()));
  }

  /// 重置书签
  resetMark() {}


  @override
  void onInit() {
    getDetail();
    // 强制横屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.onInit();
  }

  @override
  void onClose() {
    // state.imagesPath?.deleteSync(recursive: true);
    state.decryptPath?.deleteSync(recursive: true);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    dismissLoading();
    super.onClose();
  }
}
