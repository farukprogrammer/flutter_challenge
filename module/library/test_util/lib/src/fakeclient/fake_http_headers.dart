import 'dart:io';

/// author: faruk.abdul@bukalapak.com
/// date: 2021-07-09

class FakeHttpHeaders implements HttpHeaders {
  @override
  bool chunkedTransferEncoding = false;

  @override
  late int contentLength;

  @override
  ContentType? contentType;

  @override
  DateTime? date;

  @override
  DateTime? expires;

  @override
  String? host;

  @override
  DateTime? ifModifiedSince;

  @override
  bool persistentConnection = false;

  @override
  int? port;

  @override
  List<String>? operator [](String name) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    // TODO: implement add
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  void forEach(void Function(String name, List<String> values) action) {
    // TODO: implement forEach
  }

  @override
  void noFolding(String name) {
    // TODO: implement noFolding
  }

  @override
  void remove(String name, Object value) {
    // TODO: implement remove
  }

  @override
  void removeAll(String name) {
    // TODO: implement removeAll
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    // TODO: implement set
  }

  @override
  String? value(String name) {
    // TODO: implement value
    throw UnimplementedError();
  }
}
