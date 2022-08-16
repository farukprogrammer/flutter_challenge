import 'package:domain_book/domain_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_book/src/cubit/home_cubit.dart';
import 'package:ui_book/src/view/book_home_view.dart';

class BookHomePage extends StatelessWidget {
  final GetBooksUseCase getBooksUseCase;

  const BookHomePage({
    Key? key,
    required this.getBooksUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        getBooksUseCase: getBooksUseCase,
      )..load(),
      child: const BookHomeView(),
    );
  }
}
