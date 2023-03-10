import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../net/http_x.dart';
enum AssetFileType{
  pdf,
  epub,
  unknown
}
class DownloaderStore extends GetxController {
  static DownloaderStore get to => Get.find();
  late Directory? _savePath;


  @override
  void onInit() {
    super.onInit();
    _initFilePath();
  }

  Future<File?> download(String url,{ProgressCallback? onReceiveProgress,String? id}) async {
    var fileName = _getFileName(url,id: id);
    var filePath = '${_savePath?.path}/$fileName';
    File file = File(filePath);

    // 判断文件是否存在
    print('文件是否存在>>>>$fileName   ${file.existsSync()}');
    if (file.existsSync()) {
      return file;
    }

    await httpX.download(url, filePath,onReceiveProgress: onReceiveProgress);
    if (file.existsSync()) {
      return file;
    }else{
      return null;
    }
  }

  _initFilePath() async {
    var parentPath;
    if (kDebugMode) {
      parentPath = Directory('data/data/com.ddid.dbook_testnet/files');
    } else {
      parentPath = await getApplicationDocumentsDirectory();
    }
    _savePath = Directory('${parentPath?.path}/assets');

    /// 判断文件夹是否存在
    if (!_savePath!.existsSync()) {
      _savePath!.createSync(recursive: true);
    }
  }

  _getFileName(String url,{String? id}) {
    var p = url.substring(url.lastIndexOf("/") + 1);
    if(id != null){
      return p = '${id}_$p';
    }
    return p;
  }

  getFileType(String path){
    var p = path.substring(path.lastIndexOf(".") + 1);
    if(p == 'pdf'){
      return AssetFileType.pdf;
    }else if(p == 'epub'){
      return AssetFileType.epub;
    }else{
      return AssetFileType.unknown;
    }
  }
}
