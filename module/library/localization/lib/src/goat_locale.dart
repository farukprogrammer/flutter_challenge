import 'package:flutter/widgets.dart';

import 'locale_resource.dart';

abstract class GoatLocale {
  abstract final LocaleResource resource;

  final String? languageCode;

  GoatLocale(this.languageCode);

  static T of<T extends GoatLocale>(BuildContext context) {
    return Localizations.of(context, T);
  }
}
