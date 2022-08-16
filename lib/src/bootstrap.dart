import 'dart:async';

import 'package:flutter/material.dart';
import 'package:service_locator/service_locator.dart';

import 'ebook_app.dart';
import 'flavor/flavor_config.dart';

void bootstrap(FlavorConfig flavor) {
  runZonedGuarded(() async {
    // setup service locator
    ServiceLocatorInitiator.setServiceLocatorFactory(
      () => GetItServiceLocator(),
    );
    final locator = ServiceLocator.asNewInstance();

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
