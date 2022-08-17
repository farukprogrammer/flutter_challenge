import 'dart:io';

import 'fake_http_client_request.dart';

/// author: faruk.abdul@bukalapak.com
/// date: 2021-07-09

class FakeHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri? url) {
    return Future.value(FakeHttpClientRequest());
  }

  @override
  bool autoUncompress = false;

  @override
  Duration? connectionTimeout;

  @override
  late Duration idleTimeout;

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  @override
  void addCredentials(
      Uri url, String realm, HttpClientCredentials credentials) {
    // TODO: implement addCredentials
  }

  @override
  void addProxyCredentials(
      String host, int port, String realm, HttpClientCredentials credentials) {
    // TODO: implement addProxyCredentials
  }

  @override
  set authenticate(
      Future<bool> Function(Uri url, String scheme, String realm)? f) {
    // TODO: implement authenticate
  }

  @override
  set authenticateProxy(
      Future<bool> Function(String host, int port, String scheme, String realm)?
          f) {
    // TODO: implement authenticateProxy
  }

  @override
  set badCertificateCallback(
      bool Function(X509Certificate cert, String host, int port)? callback) {
    // TODO: implement badCertificateCallback
  }

  @override
  void close({bool force = false}) {
    // TODO: implement close
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) {
    // TODO: implement deleteUrl
    throw UnimplementedError();
  }

  @override
  set findProxy(String Function(Uri url)? f) {
    // TODO: implement findProxy
  }

  @override
  Future<HttpClientRequest> get(String host, int port, String path) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> head(String host, int port, String path) {
    // TODO: implement head
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> headUrl(Uri url) {
    // TODO: implement headUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> open(
      String method, String host, int port, String path) {
    // TODO: implement open
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    // TODO: implement openUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> patchUrl(Uri url) {
    // TODO: implement patchUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> post(String host, int port, String path) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> postUrl(Uri url) {
    // TODO: implement postUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> put(String host, int port, String path) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> putUrl(Uri url) {
    // TODO: implement putUrl
    throw UnimplementedError();
  }

  @override
  set connectionFactory(Future<ConnectionTask<Socket>> Function(Uri url, String? proxyHost, int? proxyPort)? f) {
    // TODO: implement connectionFactory
  }

  @override
  set keyLog(Function(String line)? callback) {
    // TODO: implement keyLog
  }
}
