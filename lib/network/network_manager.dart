import 'package:barcode_app/network/api.dart';
import 'package:barcode_app/resources/duration.dart';
import 'package:barcode_app/util/config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkManager {
  late Dio _dio;

  NetworkManager() {
    _dio = Dio(BaseOptions(
      baseUrl: Config.baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
    ));
  }

  Future<dynamic> get(String endpoint) async {
    Uri uri = Uri.parse('${_dio.options.baseUrl}$endpoint');
    try {
      final response = await _dio.getUri(uri);
      return _processResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  _processResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }

  // Handle exceptions
  _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return ApiError(error.response?.statusCode ?? 400, error.response?.statusMessage);
      } else {
        return ApiError(400, error.message);
      }
    } else {
      return error.toString();
    }
  }
}

enum Endpoint {
  products,
}
