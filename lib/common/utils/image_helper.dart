import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'loading.dart';

enum ImageType { BACKGROUNDS, ICON, LOGO }

class ImageHelper {
  ///图片扩展名，：建议使用webP，使用前先了解一下它（据说安卓4.0以下可能不兼容，不过微信都放弃4.0了）
  static const String extensionsType = ".png";

  static String wrapAssets(String url, {String fileExtensions = extensionsType}) {
    return "assets/images/" + url + fileExtensions;
  }

  static String wrapAssetsIcon(String url, {bool need1x = false, String fileExtensions = extensionsType}) {
    return 'assets/icons/${need1x ? "/1.0x" : ""}' + url + fileExtensions;
  }

  static String wrapAssetsBG(String url, {String fileExtensions = extensionsType}) {
    return 'assets/images/backgrounds/' + url + fileExtensions;
  }

  static String wrapAssetsLogo(String url, {String fileExtensions = extensionsType}) {
    return 'assets/images/logos/' + url + fileExtensions;
  }

  static String wrapAssetsDefault(String url, {String fileExtensions = extensionsType}) {
    return 'assets/images/default/' + url + fileExtensions;
  }

  static String wrapAssetsBanner(String url, {String fileExtensions = extensionsType}) {
    return 'assets/images/backgrounds/banner/' + url + fileExtensions;
  }

  static Widget placeHolder({required double width, required double height}) {
    return SizedBox(width: width, height: height, child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  //
  //
  // /// * 从相册选择或者拍照一张照片picker   插件：MultiImagePicker
  //
  // static Future<List<AssetEntity>?> pickImage(
  //   BuildContext context, {
  //   int maxImages = 1,
  //   List<AssetEntity>? selectedAssets,
  // }) async {
  //   List<AssetEntity>? resultList = <AssetEntity>[];
  //   await requestPermission();
  //   try {
  //     resultList = await AssetPicker.pickAssets(context, selectedAssets: selectedAssets, maxAssets: maxImages);
  //   } on Exception catch (e) {
  //     logx.d(e.toString());
  //   }
  //
  //   // 判断图片是否存在，iOS中有iCloud图片不存在问题
  //   List<int> nonExistent = [];
  //   for (int i = 0; i < (resultList ?? []).length; i++) {
  //     var file = await resultList![i].originFile;
  //     if (file == null) {
  //       nonExistent.add(i + 1);
  //     }
  //   }
  //
  //   if (nonExistent.length != 0) {
  //     if (resultList!.length == 1) {
  //       showError(t: '您选择的图片不存在，请重新选择');
  //     } else {
  //       showError(t: '您选择的图片中第${nonExistent.toString().replaceAll('[', '').replaceAll(']', '')}张不存在，请重新选择');
  //     }
  //     return [];
  //   }
  //
  //   return resultList;
  // }
  //
  // /// * 从相册选择或者拍照一张照片picker   插件：MultiImagePicker
  //
  // static Future<List<File>> pickImageAsFile(
  //   BuildContext context, {
  //   int maxImages = 1,
  //   List<AssetEntity>? selectedAssets,
  // }) async {
  //   List<File> images = <File>[];
  //   List<AssetEntity>? resultList = <AssetEntity>[];
  //   try {
  //     resultList = await AssetPicker.pickAssets(context, selectedAssets: selectedAssets);
  //   } on Exception catch (e) {
  //     showError(t: '选择图片失败');
  //   }
  //
  //   for (AssetEntity asset in resultList!) {
  //     File? f = await asset.file;
  //     if (f != null) {
  //       images.add(f);
  //     }
  //   }
  //
  //   return images;
  // }

  static Widget network(url, {double? width, double? height, BoxFit? fit, bool enableSlideOutPage = false, Alignment? alignment}) {
    Widget failed()=>ImageX('',type: ImageType.BACKGROUNDS,width: double.infinity,height: double.infinity,fit: BoxFit.fill);
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit??BoxFit.cover,
      enableMemoryCache: false,
      enableSlideOutPage: enableSlideOutPage,
      alignment: alignment ?? Alignment.center,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return null;
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return failed();
        }
      },
    );
  }

  /// * 保存图片到临时路径
  static Future<String> saveImage(String name, Uint8List fileData) async {
    //Image image = Image.memory(fileData);
    Directory tempDir = await getTemporaryDirectory();
    debugPrint(tempDir.path);
    File file = File("${tempDir.path}/$name.png");
    file.writeAsBytesSync(fileData);
    debugPrint(file.path);
    return file.path;
  }

  /// 图片是否为横向  判断依据-宽高比大于4:3
  static bool horizontalImage(String url) {
    Image image = Image.network(url);
    bool horizontal = false;
    image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((imageInfo, _) => {
      if (imageInfo.image.width / imageInfo.image.height > 4 / 3) {horizontal = true}
    }));
    return horizontal;
  }

  /// 动态申请相册权限
  static Future<bool> requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestPhotosPermission();
    if (hasLocationPermission) {
      print("相册权限申请通过");
    } else {
      showError(t: '请开启访问相册需要的权限');
      openAppSettings();
    }

    return hasLocationPermission;
  }

  /// 申请文件/相册权限
  /// 授予文件/相册权限返回true， 否则返回false
  static Future<bool> requestPhotosPermission() async {
    var permission = Platform.isAndroid ? Permission.storage : Permission.photos;
    //获取当前的权限
    var status = await permission.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await permission.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}

Image ImageX(String imageName, {ImageType? type = ImageType.ICON,Color? color, final double? width, final double? height, final BoxFit? fit,String fileExtensions = ImageHelper
    .extensionsType}) {
  String imagePath;
  if (type == ImageType.BACKGROUNDS) {
    imagePath = ImageHelper.wrapAssetsBG(imageName,fileExtensions: fileExtensions);
  } else if (type == ImageType.ICON) {
    imagePath = ImageHelper.wrapAssetsIcon(imageName,fileExtensions: fileExtensions);
  } else if (type == ImageType.LOGO) {
    imagePath = ImageHelper.wrapAssetsLogo(imageName,fileExtensions: fileExtensions);
  } else {
    imagePath = imageName;
  }

  return Image.asset(
    imagePath,
    width: width,
    height: height,
    fit: fit,
    color: color,
  );
}
