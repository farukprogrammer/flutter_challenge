import 'package:collection/collection.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:go_router/go_router.dart';

import '../locale/book_locale.dart';

class BookDetailPage extends StatelessWidget {
  final int bookId;
  final Book? bookData;

  const BookDetailPage({
    Key? key,
    required this.bookId,
    this.bookData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);
    final authorName = bookData?.authors.firstOrNull?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('${locale.booksDetail} : ${bookData?.title}'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.goNamed(
                'search_result',
                params: {
                  'id': '$bookId',
                },
                queryParams: {
                  'author': authorName,
                },
              ),
              child: Text('Go to ${locale.authors(authorName)}'),
            ),
          ],
        ),
      ),
    );
  }
}
