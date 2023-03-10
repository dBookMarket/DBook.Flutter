import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'bedrock_http.dart';

final HttpX httpX = HttpX();

/// todo 此类经过优化只处理[_handleResponse]了一层数据,后期准备废弃
class HttpX {
  ///检查网络状态
  Future<bool> checkNet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none;
  }

  Future<dynamic> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress, bool enableHandle = true}) async {
    Response response = await apiServer.get<T>(path, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);

    return _handleResponse(response, handle: enableHandle);
  }

  Future<dynamic> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool enableHandle = true}) async {
    Response response =
        await apiServer.post<T>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
    return _handleResponse(response, handle: enableHandle);
  }

  Future<dynamic> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool enableHandle = true}) async {
    Response response = await apiServer.put<T>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
    return _handleResponse(response, handle: enableHandle);
  }

  Future<dynamic> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, bool enableHandle = true}) async {
    Response response = await apiServer.delete<T>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
    return _handleResponse(response, handle: enableHandle);
  }

  Future<dynamic> patch<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, bool enableHandle = true}) async {
    Response response = await apiServer.patch<T>(path, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
    return _handleResponse(response, handle: enableHandle);
  }

  Future<Response> download<T>(String urlPath, savePath,
      {ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options}) async {
    Response response = await apiServer.download(urlPath, savePath,
        onReceiveProgress: onReceiveProgress, queryParameters: queryParameters, cancelToken: cancelToken, deleteOnError: deleteOnError, lengthHeader: lengthHeader, data: data, options: options);
    return response;
  }

  dynamic _handleResponse(Response response, {bool handle = true}) {
    if (!handle) {
      return response;
    }

    return response.data;
  }
}
