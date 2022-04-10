import 'dart:math';
import 'package:flutter/cupertino.dart';
class ImageHelper {

  ///图片扩展名，：建议使用webP，使用前先了解一下它（据说安卓4.0以下可能不兼容，不过微信都放弃4.0了）
  static const String extensionsType = ".png";


  static String wrapAssets(String url, {String fileExtensions = extensionsType}) {
    return "assets/images/" + url + fileExtensions;
  }

  static String wrapAssetsIcon(String url, {bool need1x = false, String fileExtensions = extensionsType}) {
    return 'assets/images/icons/${need1x ? "/1.0x" : ""}' + url + fileExtensions;
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
}
