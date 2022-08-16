import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_client/network_client.dart';
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

    // inject all dependency with registering all the registrar
    await Future.wait([
      locator.registerRegistrar(NetworkClientRegistrar(baseUrl: flavor.baseUrl)),
    ]);

    runApp(
      EbookApp(
        locator: locator,
        supportedLocales: flavor.supportedLocales,
      ),
    );
  }, (error, stackTrace) {
    // todo: uncomment this when connect to firebase crashlytics
    // FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
