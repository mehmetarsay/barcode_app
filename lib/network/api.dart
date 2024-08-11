import 'package:barcode_app/locator.dart';
import 'package:flutter/foundation.dart';

typedef ErrorHandlers = Map<String, Function(dynamic)?>;

extension ApiExtensions on Future {
  req([ErrorHandlers? errors]) => then(
        onError: (e, s) => throw ApiError(400, e.message, inner: e, stackTrace: s),
        (response) {
          if (response == null) {
            throw const ApiError(400, 'response is null');
          }
          try {
            return response;
          } catch (ignored) {
            // ignore: empty_catches
          }
        },
      );

  reqList([ErrorHandlers? errors]) => req(errors).then((data) => data!.result);
}

class Api {
  Api._();

  static const noConnection = 'The connection errored';

  static handleError(e, s) async {
    if (kDebugMode) print('Api error: $e $s');
    if (e is ApiError) {
      if (e.code == 400) {
        return navigator.dialog(title: 'Hata', description: noConnection);
      } else {
        return navigator.dialog(title: 'Hata', description: e.message);
      }
    } else if (e is ErrorException) {
      return navigator.dialog(title: 'Hata', description: e.message);
    }
    return navigator.dialog(title: 'Hata', description: e.toString());
  }
}

class ApiError implements Exception {
  final int code;
  final String? message;
  final Exception? inner;
  final StackTrace? stackTrace;

  const ApiError(this.code, this.message, {this.inner, this.stackTrace});

  @override
  String toString() {
    String s = 'ApiError';
    if (code != 0) s += ' $code';
    if (message != null) s += ' $message';
    if (inner != null) s += '\n$inner';
    if (stackTrace != null) s += '\n$stackTrace';
    return s;
  }
}

class ErrorException implements Exception {
  final String message;

  ErrorException(this.message);

  @override
  String toString() {
    return 'ErrorException: $message';
  }
}
