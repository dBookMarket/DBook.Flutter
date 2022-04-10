import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dbook/common/net/bedrock_http.dart';
import 'package:dbook/common/net/http_x.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'api_constants.dart';

class BaseApi {
  /// 文件上传
  Future upload(File file, {
    ProgressCallback? onSendProgress,CancelToken? cancelToken
  }) async {
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
      quality: 80,percentage: 50);
    // File? result = await FlutterImageCompress.compressAndGetFile(
    //   file.absolute.path, 'jidao_compress',
    //   quality: 88,
    // );
    // logx.d('压缩图片${file.path}\n${result?.path}');
    var path = compressedFile.path;
    var name = path.substring(path.lastIndexOf('/')+1,path.length);
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path, filename: name),
    });

    ResponseData response = await httpX.post(ApiConstants.upload, data: formData, onSendProgress: onSendProgress,cancelToken: cancelToken);
    return response.data;
  }

}
