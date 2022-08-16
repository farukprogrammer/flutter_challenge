import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../exception/no_internet_exception.dart';

class RequestInterceptor extends Interceptor {
  final InternetConnectionChecker internetConnectionChecker;

  RequestInterceptor(this.internetConnectionChecker);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await internetConnectionChecker.hasConnection) {
      super.onRequest(options, handler);
    } else {
      _sendConnectionError(options, handler);
    }
  }

  void _sendConnectionError(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.reject(DioError(
      requestOptions: options,
      response: null,
      type: DioErrorType.connectTimeout,
      error: const NoInternetException(),
    ));
  }
}
