
import 'dart:io';

import 'package:dbook/common/entities/read_info_entity.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';


class AssetDetailState {
  late final String bookName;
  late final int bookId;
  late final int currentPage;
  late final int markId;
  late final int markIssue;
  late final Directory? decryptPath;
  late final Directory? imagesPath;


  final currentIndex = 1.obs;
  final readInfo = ReadInfoEntity().obs;

  final localFile = <dynamic>[].obs;

  AssetDetailState() {
    bookName = Get.arguments?['bookName']??'';
    bookId = Get.arguments?['bookId']??'';
    currentPage = Get.arguments?['currentPage']??'';
    markId = Get.arguments?['markId']??'';
    markIssue = Get.arguments?['markIssue']??'';
    currentIndex.value = currentPage;
    logX.d(Get.arguments);
    initFilePath();
  }

  initFilePath()async{
    // var parentPath = await getExternalStorageDirectory();
    var parentPath = Directory('data/data/com.ddid.dbook/files');
    decryptPath = Directory('${parentPath?.path}/${bookName}_$bookId');
    /// 判断文件夹是否存在
    if (!decryptPath!.existsSync()) {
      decryptPath!.createSync(recursive: true);
    }

    imagesPath = Directory('${parentPath?.path}/${bookName}_$bookId/images');
    /// 判断文件夹是否存在
    if (!imagesPath!.existsSync()) {
      imagesPath!.createSync(recursive: true);
    }
  }


}
