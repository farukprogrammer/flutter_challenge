import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:go_router/go_router.dart';
import 'package:result_util/result_util.dart';
import 'package:ui_book/src/cubit/detail_cubit.dart';
import 'package:ui_book/src/state/detail_state.dart';

import '../locale/book_locale.dart';

class DetailView extends StatefulWidget {
  final int bookId;

  const DetailView({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DetailCubit>();
    if (cubit.state.apiResult.value == null) {
      cubit.load();
    }
  }
  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.booksDetail),
        centerTitle: true,
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          final bookData = state.apiResult.asData?.value;
          final authorName = bookData?.authors.firstOrNull?.name ?? '';
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => context.goNamed(
                    'search_result',
                    params: {
                      'id': state.bookId,
                    },
                    queryParams: {
                      'author': authorName,
                    },
                  ),
                  child: Text('Go to ${locale.authors(authorName)}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
