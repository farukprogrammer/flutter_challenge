import 'dart:convert';
import 'dart:io';

import 'fake_http_client_response.dart';
import 'fake_http_headers.dart';

/// author: faruk.abdul@bukalapak.com
/// date: 2021-07-09

class FakeHttpClientRequest implements HttpClientRequest {
  @override
  HttpHeaders get headers => FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() => Future.value(FakeHttpClientResponse());

  @override
  bool bufferOutput = false;

  @override
  int contentLength = 0;

  @override
  late Encoding encoding;

  @override
  bool followRedirects = false;

  @override
  int maxRedirects = 0;

  @override
  bool persistentConnection = false;

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    // TODO: implement abort
  }

  @override
  void add(List<int> data) {
    // TODO: implement add
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    // TODO: implement addStream
    throw UnimplementedError();
  }

  @override
  // TODO: implement connectionInfo
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  // TODO: implement cookies
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  // TODO: implement done
  Future<HttpClientResponse> get done => throw UnimplementedError();

  @override
  Future flush() {
    // TODO: implement flush
    throw UnimplementedError();
  }

  @override
  // TODO: implement method
  String get method => throw UnimplementedError();

  @override
  // TODO: implement uri
  Uri get uri => throw UnimplementedError();

  @override
  void write(Object? object) {
    // TODO: implement write
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    // TODO: implement writeAll
  }

  @override
  void writeCharCode(int charCode) {
    // TODO: implement writeCharCode
  }

  @override
  void writeln([Object? object = ""]) {
    // TODO: implement writeln
  }
}
