import 'package:domain_book/domain_book.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_book/src/view/detail_view.dart';

import '../cubit/detail_cubit.dart';

class BookDetailPage extends StatelessWidget {
  final int bookId;
  final Book? bookData;
  final GetBookDetailUseCase getBookDetailUseCase;

  const BookDetailPage({
    Key? key,
    required this.bookId,
    required this.getBookDetailUseCase,
    this.bookData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailCubit>(
      create: (context) => DetailCubit(
        getBookDetailUseCase: getBookDetailUseCase,
        bookId: bookId,
        bookData: bookData,
      ),
      child: DetailView(
        bookId: bookId,
      ),
    );
  }
}
