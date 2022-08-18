import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'fakeclient/fake_http_overrides.dart';

@isTest
void testPage(
  String description, {
  required Widget Function() pageBuilder,
  required Future<void> Function(WidgetTester) then,
  required LocalizationsDelegate localeDelegate,
  Future<void> Function()? given,
  Iterable<Locale>? supportedLocales,
  bool? skip,
  Iterable<String>? tags,
}) {
  testWidgets(
    description,
    (tester) async {
      await given?.call();

      HttpOverrides.global = FakeHttpOverrides();
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [localeDelegate],
          supportedLocales: supportedLocales ?? const [Locale('en', 'US')],
          home: pageBuilder(),
        ),
      );

      // additional pump for initialization of localization delegate.
      await tester.pump();
      await then(tester);
    },
    skip: skip,
    tags: tags,
  );
}
