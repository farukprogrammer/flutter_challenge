import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:service_locator/service_locator.dart';
import 'package:ui_book/ui_book.dart';
import 'package:entity_book/entity_book.dart';

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
    final GoRouter router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => BookHomePage(
            getBooksUseCase: locator(),
          ),
          routes: <GoRoute>[
            GoRoute(
              name: 'detail',
              path: 'detail/:id',
              builder: (BuildContext context, GoRouterState state) =>
                  BookDetailPage(
                bookId: int.tryParse(state.params['id'] ?? '') ?? 0,
                bookData: state.extra as Book?,
              ),
              routes: <GoRoute>[
                GoRoute(
                  name: 'search_result',
                  path: 'search_result',
                  builder: (
                    BuildContext context,
                    GoRouterState state,
                  ) {
                    return BookSearchResultPage(
                      getBooksUseCase: locator(),
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

    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
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
