import 'package:dbook/common/values/colors.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../common/services/downloader.dart';
import '../../common/widgets/appBar.dart';
import 'asset_detail_logic.dart';

class AssetDetailPage extends StatelessWidget {
  final logic = Get.put(AssetDetailLogic());
  final state = Get.find<AssetDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: _appBar(),
        body: BaseContainer(viewState: state.viewState, child: _asset(), background: ColorX.primaryYellow2),
        drawer: _epubDrawer(),
      );
    });
  }

  AppBar _appBar() {
    if (state.assetType.value == AssetFileType.epub) {
      return AppBar(
        title: _appBarEpub(),
        actions: [_close()],
      );
    } else if (state.assetType.value == AssetFileType.pdf){
      return appBar(title: logic.getPdfTag());
    }else{
      return appBar();
    }
  }

  Widget _close() => IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Get.back();
        },
      );

  Widget _appBarEpub() => EpubViewActualChapter(
      controller: state.epubController,
      builder: (chapterValue) => Text(
            (chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''),
            textAlign: TextAlign.start,
          ));

  Widget? _epubDrawer() {
    if (state.assetType.value == AssetFileType.epub) {
      return Drawer(
        child: EpubViewTableOfContents(
          controller: state.epubController,
        ),
      );
    } else {
      return null;
    }
  }

  Widget _asset() {
    return Obx(() {
      if (state.assetType.value == AssetFileType.pdf) {
        return _pdf();
      } else if (state.assetType.value == AssetFileType.epub) {
        return _epub();
      } else {
        return SizedBox();
      }
    });
  }

  Widget _pdf() => PdfView(controller: state.pdfController!,onPageChanged: logic.onPageChanged);

  Widget _epub() => EpubView(controller: state.epubController,onChapterChanged: logic.onChapterChanged);
}
