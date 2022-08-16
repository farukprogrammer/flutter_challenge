import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:service_locator/service_locator.dart';
import 'package:ui_book/ui_book.dart';

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

class EbookApp extends StatelessWidget {
  final ServiceLocator locator;
  final Iterable<Locale> supportedLocales;

  const EbookApp({
    Key? key,
    required this.locator,
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
      title: 'EBook App',
      debugShowCheckedModeBanner: false,
      supportedLocales: supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
