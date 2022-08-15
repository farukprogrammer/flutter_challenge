import 'dart:ui';

class FlavorConfig {
  final String name;
  final String baseUrl;
  final Iterable<Locale> supportedLocales;

  FlavorConfig({
    required this.name,
    required this.baseUrl,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
  });
}