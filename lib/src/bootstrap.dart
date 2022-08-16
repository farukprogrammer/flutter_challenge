import 'dart:async';

import 'package:flutter/material.dart';

import 'ebook_app.dart';
import 'flavor/flavor_config.dart';

void bootstrap(FlavorConfig flavor) {
  runZonedGuarded(() async {
    runApp(
      EbookApp(
        title: flavor.name,
        supportedLocales: flavor.supportedLocales,
      ),
    );
  }, (error, stackTrace) {
    // todo: uncomment this when connect to firebase crashlytics
    // FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
