import 'package:dbook/common/entities/read_info_entity.dart';
import 'package:dbook/common/widgets/view_state/view_state.dart';
import 'package:epub_view/epub_view.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../common/services/downloader.dart';



class AssetDetailState extends BaseState{
  int? assetId;
  String? downloadUrl;
  final readInfo = ReadInfoEntity().obs;
  final assetType = AssetFileType.unknown.obs;
  String? fileName;

  late PdfController? pdfController;
  late EpubController epubController;

  final pdfCurrentIndex = 0.obs;

  AssetDetailState() {
    assetId = Get.arguments?['assetId'];
    downloadUrl = Get.arguments?['downloadUrl'] ?? '';
  }

}
