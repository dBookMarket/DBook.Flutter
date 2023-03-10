import 'dart:io';

import 'package:dbook/business/service_api/base/net_work.dart';
import 'package:dbook/common/services/downloader.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:epub_view/epub_view.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../common/services/storage.dart';
import 'asset_detail_state.dart';

class AssetDetailLogic extends GetxController {
  final AssetDetailState state = AssetDetailState();

  getDetail() async {
    showLoading();

    if (state.assetId == null) {
      await downLoadFile(state.downloadUrl ?? '');
    } else {
      state.readInfo.value = await NetWork.getInstance().assets.assetsDetail(state.assetId!).onError((error, stackTrace) => dismissLoading());
      if (state.readInfo.value.fileUrl == null || state.readInfo.value.fileUrl!.isEmpty) {
        state.setError(t: 'invalid file url');
        return;
      }
      await downLoadFile(state.readInfo.value.fileUrl!);
    }

    dismissLoading();
  }

  // 下载文件
  downLoadFile(String url) async {
    state.setBusy();
    File? file = await DownloaderStore.to.download(url, id: state.assetId.toString(), onReceiveProgress: (received, total) {
      if (total == -1) return;
      var p = received / total;
      state.setProgress(p: p, t: (p * 100).toStringAsFixed(0) + '%');
    });
    state.setIdle();
    if (file == null) {
      state.setError(t: 'download file failed');
      return;
    }

    state.fileName = file.path.split('/').last;


    state.assetType.value = DownloaderStore.to.getFileType(file.path);
    initReader(file);

  }

  initReader(File file){
    if (state.assetType.value == AssetFileType.pdf) {
      var index = StorageService.to.getInt(state.fileName!, defValue: 0);
      state.pdfCurrentIndex.value = index;
      state.pdfController = PdfController(
        document: PdfDocument.openFile(file.path),
        initialPage: index,
      );
    } else if (state.assetType.value == AssetFileType.epub) {
      var cfi = StorageService.to.getString(state.fileName!);
      state.epubController = EpubController(
        document: EpubDocument.openFile(file),
        epubCfi: cfi
      );
    }
  }

  getPdfTag(){
    if(state.pdfController == null) return;
    Future.delayed(Duration(milliseconds: 200)).then((value) => state.pdfCurrentIndex.refresh());
    return '${state.pdfCurrentIndex.value}/${state.pdfController?.pagesCount??''}';
  }

  onChapterChanged(chapter){
    if(state.assetId == null||state.fileName == null) return;
    var cfi = state.epubController.generateEpubCfi();
    StorageService.to.setString(state.fileName!, cfi??'');
  }

  onPageChanged(int page){
    state.pdfCurrentIndex.value = page;
    if(state.assetId == null||state.fileName == null) return;
    StorageService.to.setInt(state.fileName!, page);
  }

  /// 重置书签
  resetMark() {}

  @override
  void onInit() {
    getDetail();
    super.onInit();
  }

  @override
  void onClose() {
    dismissLoading();
    super.onClose();
  }
}
