import 'package:domain_book/domain_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../cubit/book_list_cubit.dart';
import '../locale/book_locale.dart';
import '../view/book_list_view.dart';

class BookSearchResultPage extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;
  final String author;

  const BookSearchResultPage({
    Key? key,
    required this.getBooksUseCase,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return BlocProvider<BookListCubit>(
      create: (context) => BookListCubit(
        getBooksUseCase: getBooksUseCase,
        keyword: author,
      )..load(keyword: author),
      child: BookListView(
        title: locale.authors(author),
        isUseSearchBar: false,
      ),
    );
  }
}
