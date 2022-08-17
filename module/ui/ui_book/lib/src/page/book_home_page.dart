import 'package:domain_book/domain_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:ui_book/src/cubit/book_list_cubit.dart';
import 'package:ui_book/src/view/book_list_view.dart';

import '../locale/book_locale.dart';

class BookHomePage extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;

  const BookHomePage({
    Key? key,
    required this.getBooksUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return BlocProvider<BookListCubit>(
      create: (context) => BookListCubit(
        getBooksUseCase: getBooksUseCase,
      )..load(),
      child: BookListView(
        title: locale.books,
        isUseSearchBar: true,
      ),
    );
  }
}
