import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../locale/book_locale.dart';

class BookSearchResultPage extends StatelessWidget {
  final String author;

  const BookSearchResultPage({
    Key? key,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.authors(author)),
        centerTitle: true,
      ),
    );
  }
}
