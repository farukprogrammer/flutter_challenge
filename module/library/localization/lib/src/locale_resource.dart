// ignore_for_file:prefer_conditional_assignment

abstract class LocaleResource {
  abstract final Map<String, Map<String, String>> data;

  final String? languageCode;

  LocaleResource(this.languageCode);

  String get(String key, {List<dynamic> args = const []}) {
    final resource = data[key];
    var locale = resource?[languageCode];
    // use default language when localization failed.
    if (locale == null) {
      locale = resource?['default'];
      if (locale == null) {
        throw Exception('Error: failed to provide $key from locale resource');
      }
    }

    if (args.isNotEmpty) {
      for (var element in args) {
        locale = locale?.replaceFirst('%s', element.toString());
      }
    }

    return locale ?? '';
  }
}
