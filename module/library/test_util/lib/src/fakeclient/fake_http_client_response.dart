import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// author: faruk.abdul@bukalapak.com
/// date: 2021-07-09

class FakeHttpClientResponse implements HttpClientResponse {
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  int get contentLength => image.length;

  @override
  int get statusCode => HttpStatus.ok;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int>)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable(<List<int>>[image]).listen(onData,
        onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  }

  @override
  Future<bool> any(bool Function(List<int> element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> asBroadcastStream(
      {void Function(StreamSubscription<List<int>> subscription)? onListen,
      void Function(StreamSubscription<List<int>> subscription)? onCancel}) {
    // TODO: implement asBroadcastStream
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(List<int> event) convert) {
    // TODO: implement asyncExpand
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(List<int> event) convert) {
    // TODO: implement asyncMap
    throw UnimplementedError();
  }

  @override
  Stream<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  // TODO: implement certificate
  X509Certificate? get certificate => throw UnimplementedError();

  @override
  // TODO: implement connectionInfo
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  Future<bool> contains(Object? needle) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  // TODO: implement cookies
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  Future<Socket> detachSocket() {
    // TODO: implement detachSocket
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> distinct(
      [bool Function(List<int> previous, List<int> next)? equals]) {
    // TODO: implement distinct
    throw UnimplementedError();
  }

  @override
  Future<E> drain<E>([E? futureValue]) {
    // TODO: implement drain
    throw UnimplementedError();
  }

  @override
  Future<List<int>> elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  Future<bool> every(bool Function(List<int> element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(List<int> element) convert) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Future<List<int>> get first => throw UnimplementedError();

  @override
  Future<List<int>> firstWhere(bool Function(List<int> element) test,
      {List<int> Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  Future<S> fold<S>(
      S initialValue, S Function(S previous, List<int> element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Future forEach(void Function(List<int> element) action) {
    // TODO: implement forEach
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> handleError(Function onError,
      {bool Function(dynamic)? test}) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  @override
  // TODO: implement headers
  HttpHeaders get headers => throw UnimplementedError();

  @override
  // TODO: implement isBroadcast
  bool get isBroadcast => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  Future<bool> get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isRedirect
  bool get isRedirect => throw UnimplementedError();

  @override
  Future<String> join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Future<List<int>> get last => throw UnimplementedError();

  @override
  Future<List<int>> lastWhere(bool Function(List<int> element) test,
      {List<int> Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  Future<int> get length => throw UnimplementedError();

  @override
  Stream<S> map<S>(S Function(List<int> event) convert) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  // TODO: implement persistentConnection
  bool get persistentConnection => throw UnimplementedError();

  @override
  Future pipe(StreamConsumer<List<int>> streamConsumer) {
    // TODO: implement pipe
    throw UnimplementedError();
  }

  @override
  // TODO: implement reasonPhrase
  String get reasonPhrase => throw UnimplementedError();

  @override
  Future<HttpClientResponse> redirect(
      [String? method, Uri? url, bool? followLoops]) {
    // TODO: implement redirect
    throw UnimplementedError();
  }

  @override
  // TODO: implement redirects
  List<RedirectInfo> get redirects => throw UnimplementedError();

  @override
  Future<List<int>> reduce(
      List<int> Function(List<int> previous, List<int> element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Future<List<int>> get single => throw UnimplementedError();

  @override
  Future<List<int>> singleWhere(bool Function(List<int> element) test,
      {List<int> Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> skipWhile(bool Function(List<int> element) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> takeWhile(bool Function(List<int> element) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> timeout(Duration timeLimit,
      {void Function(EventSink<List<int>> sink)? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<List<List<int>>> toList() {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Future<Set<List<int>>> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<List<int>, S> streamTransformer) {
    // TODO: implement transform
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> where(bool Function(List<int> event) test) {
    // TODO: implement where
    throw UnimplementedError();
  }
}

//transparent pixel in png format
final image = base64Decode(
  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
);
