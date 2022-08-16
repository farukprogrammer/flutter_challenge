import 'dart:convert';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:network_client/src/goat_response_array.dart';

import 'interceptor/request_interceptor.dart';

class NetworkClient extends DioForNative {
  final String baseUrl;
  final RequestInterceptor _requestInterceptor;

  NetworkClient(
    this.baseUrl, {
    required RequestInterceptor requestInterceptor,
    BaseOptions? options,
  })  : _requestInterceptor = requestInterceptor,
        super(options) {
    _configureOptions();
    _configureInterceptor();
  }

  void _configureOptions() {
    options.baseUrl = baseUrl;
  }

  void _configureInterceptor() {
    interceptors.add(_requestInterceptor);
  }

  Future<Result<T>> getRequest<T>(
    T Function(Map<String, dynamic>) decoder, {
    String path = "",
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? errorPayloadKey,
  }) async {
    try {
      final rawResponse = await get<String>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      if (rawResponse.data != null) {
        final json = jsonDecode(rawResponse.data!);
        if (json is T) {
          return Result.value(json);
        } else {
          if (errorPayloadKey?.isNotEmpty == true &&
              json[errorPayloadKey] != null) {
            return Result.error(Exception(json[errorPayloadKey]));
          }
          return Result.value(decoder(json));
        }
      } else {
        // if response is null then return error
        return Result.error(Exception('mull response'));
      }
    } on DioError catch (e) {
      return Result.error(e);
    } on Exception catch (ex) {
      return Result.error(ex);
    }
  }

  Future<Result<List<T>>> getRequestArray<T>(
    T Function(Map<String, dynamic>) decoder, {
    String path = "",
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final rawResponse = await get<String>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      if (rawResponse.data != null) {
        final json = jsonDecode(rawResponse.data!);
        final response = GoatResponseArray<T>.fromJson(json, decoder);
        return Result.value(response.results);
      } else {
        // if response is null then return empty list
        return Result.value([]);
      }
    } on DioError catch (e) {
      return Result.error(e);
    } on Exception catch (ex) {
      return Result.error(ex);
    }
  }

  Future<Result<GoatResponseArray<T>>> getRequestArrayFull<T>(
    T Function(Map<String, dynamic>) decoder, {
    String path = "",
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final rawResponse = await get<String>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      if (rawResponse.data != null) {
        final json = jsonDecode(rawResponse.data!);
        final response = GoatResponseArray<T>.fromJson(json, decoder);
        return Result.value(response);
      } else {
        // if response is null then return empty Response Array
        return Result.value(GoatResponseArray());
      }
    } on DioError catch (e) {
      return Result.error(e);
    } on Exception catch (ex) {
      return Result.error(ex);
    }
  }
}
