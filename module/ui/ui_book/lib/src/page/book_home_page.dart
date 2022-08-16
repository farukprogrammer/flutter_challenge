import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:base_component/base_component.dart';

import '../locale/book_locale.dart';

class BookHomePage extends StatelessWidget {
  const BookHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.books),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBarComponent(
                placeholder: locale.search,
              ),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed('detail'),
              child: Text('Go to ${locale.booksDetail}'),
            ),
          ],
        ),
      ),
    );
  }
}
