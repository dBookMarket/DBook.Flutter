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

  onPageChanged(index, _) {
    logX.d('切换页面$index');
    state.currentIndex.value = index;
    loadingImage();
  }

  getDetail() async {
    showLoading();
    state.readInfo.value = await NetWork.getInstance().assets.assetsDetail(state.bookId).onError((error, stackTrace) => dismissLoading());
    for (var i in state.readInfo.value.files ?? []) {
      state.localFile.add('loading');
    }
    logX.d(state.localFile);
    await loadingImage();
    dismissLoading();
  }

  loadingImage() async {
    logX.d('开始加载第${state.currentIndex.value}页');
    await Future.wait([
      downloadSSE(state.currentIndex.value - 1),
      download(state.currentIndex.value),
      downloadSSE(state.currentIndex.value + 1),
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
    if(ssePath == null || skPath == null) return;
    final File? image = await DBookCryptologyPlugin.decryptImage(filePath: tempImagePath, encFile: ssePath, skFile: skPath);
    //等待
    await Future.delayed(Duration(milliseconds: 200));
    if (image != null) {
      state.localFile[index] = image;
    } else {
      loadingError(index);
    }
  }

  Future downloadSSE(int index) async {
    if (index < 0 || index + 1 > (state.readInfo.value.files?.length ?? 0)) return;
    var tempPath = '${state.decryptPath?.path}/$index.sse';
    File tempFile = File(tempPath);
    if (tempFile.existsSync()) return tempPath;

    await Dio().download(state.readInfo.value.files![index], tempPath, onReceiveProgress: (int count, int total) {
      //进度
      var progress = count / total * 100;
      // state.localFile[index] = '${progress.round()}%';
      // if(progress == 100){
      //   state.localFile[index] = 'loading';
      // }
    }).onError((error, stackTrace) => loadingError(index));
    print('downloadSSE>>>>>>>>$index路径返回');
    return tempPath;
  }

  downloadSK(int index) async {
    var tempPath = '${state.decryptPath?.path}/${state.bookName}.stk';
    File tempFile = File(tempPath);
    if (tempFile.existsSync()) return tempPath;

    // test
    // var bytes = await rootBundle.load(Assets.filesBaseBlock);
    // ByteBuffer buffer =  bytes.buffer;
    // tempFile.writeAsBytes(buffer.asUint8List(bytes.offsetInBytes,
    //     bytes.lengthInBytes));
    // return tempPath;

    await Dio().download(state.readInfo.value.sk ?? '', tempPath).onError((error, stackTrace) => logX.d(error));
    return tempPath;
  }

  loadingError(index){
    state.localFile[index] = 'load error';
  }

  /// 新建书签
  createMark() async {
    var listState = Get.find<AssetsLogic>().state;
    // 更新列表书签
    listState.list.where((p0) => p0.id == state.bookId).first.bookmark?.currentPage = state.currentIndex.value;
    listState.list.refresh();
    await NetWork.getInstance().assets.mark(issue: state.markIssue, page: state.currentIndex.value, markId: state.markId).onError((error, stackTrace) => showError(t: error.toString()));
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
    createMark();
    state.decryptPath?.deleteSync(recursive: true);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    dismissLoading();
    super.onClose();
  }
}
