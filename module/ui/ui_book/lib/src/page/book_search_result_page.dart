import 'package:domain_book/domain_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/book_list_cubit.dart';
import '../view/book_list_view.dart';

class BookSearchResultPage extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;
  final String field;
  final String keyword;

  const BookSearchResultPage({
    Key? key,
    required this.getBooksUseCase,
    required this.field,
    required this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookListCubit>(
      create: (context) => BookListCubit(
        getBooksUseCase: getBooksUseCase,
        keyword: keyword,
      )..load(keyword: keyword),
      child: BookListView(
        title: '$field: $keyword',
        isUseSearchBar: false,
      ),
    );
  }
}
