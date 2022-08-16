import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_book/ui_book.dart';

import 'flavor/flavor_config.dart';

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const BookHomePage(),
      routes: <GoRoute>[
        GoRoute(
          name: 'detail',
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) =>
              const BookDetailPage(),
          routes: <GoRoute>[
            GoRoute(
              name: 'search_result',
              path: 'search_result',
              builder: (
                BuildContext context,
                GoRouterState state,
              ) {
                return BookSearchResultPage(
                  author: state.queryParams['author'] ?? '',
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

final _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  BookLocaleDelegate(),
];

void bootstrap(FlavorConfig flavor) {
  runZonedGuarded(() async {
    runApp(
      MyApp(
        title: flavor.name,
        supportedLocales: flavor.supportedLocales,
      ),
    );
  }, (error, stackTrace) {
    // todo: uncomment this when connect to firebase crashlytics
    // FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

class MyApp extends StatelessWidget {
  final String title;
  final Iterable<Locale> supportedLocales;

  const MyApp({
    Key? key,
    required this.title,
    required this.supportedLocales,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      localizationsDelegates: _localizationsDelegates,
      title: 'Flutter Demo Page - $title',
      debugShowCheckedModeBanner: false,
      supportedLocales: supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
