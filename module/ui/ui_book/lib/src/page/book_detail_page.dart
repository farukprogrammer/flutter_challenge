import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:go_router/go_router.dart';

import '../locale/book_locale.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.booksDetail),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.goNamed('search_result', queryParams: {
                'author': 'test',
              }),
              child: Text('Go to ${locale.authors('test')}'),
            ),
          ],
        ),
      ),
    );
  }
}
