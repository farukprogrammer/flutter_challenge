import 'dart:io';

import 'fake_http_client.dart';

class FakeHttpOverrides extends HttpOverrides {
  bool warningPrinted = false;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return FakeHttpClient();
  }
}
